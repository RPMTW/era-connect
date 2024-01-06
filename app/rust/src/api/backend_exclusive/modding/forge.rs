use std::{
    collections::{HashMap, HashSet},
    io::{BufRead, BufReader},
    path::PathBuf,
    process::Stdio,
    sync::{
        atomic::{AtomicUsize, Ordering},
        Arc,
    },
};

use anyhow::{anyhow, Context, Result};
use bytes::Bytes;
use log::{debug, error, warn};
use serde::{Deserialize, Serialize};
use serde_json::Value;
use tokio::{fs, io::AsyncBufReadExt};

use crate::api::backend_exclusive::{
    download::{download_file, validate_sha1, DownloadArgs, HandlesType},
    vanilla::{
        launcher::{GameOptions, JvmOptions, LaunchArgs, ProcessedArguments},
        manifest::GameManifest,
    },
};

#[derive(Debug, Serialize, Deserialize, Clone)]
struct Processors {
    jar: String,
    classpath: Vec<String>,
    args: Vec<String>,
    sides: Option<Vec<String>>,
    outputs: Option<HashMap<String, String>>,
}
#[derive(Debug, Serialize, Deserialize, Clone)]
#[serde(rename_all = "SCREAMING_SNAKE_CASE")]
struct ProcessorData {
    merged_mappings: ProcessorsDataType,
    /// added at 1.20.4
    merged_mappings_sha: Option<ProcessorsDataType>,
    mappings: ProcessorsDataType,
    /// removed from 1.20.4
    mc_extra: Option<ProcessorsDataType>,
    /// removed from 1.20.4
    mc_extra_sha: Option<ProcessorsDataType>,
    /// removed from 1.20.4
    mc_slim: Option<ProcessorsDataType>,
    /// removed from 1.20.4
    mc_slim_sha: Option<ProcessorsDataType>,
    mc_unpacked: ProcessorsDataType,
    mc_srg: ProcessorsDataType,
    /// removed from 1.20.4
    mcp_version: Option<ProcessorsDataType>,
    mojmaps: ProcessorsDataType,
    patched: ProcessorsDataType,
    /// removed from 1.20.4
    patched_sha: Option<ProcessorsDataType>,
    binpatch: ProcessorsDataType,
}

#[derive(Debug, Serialize, Deserialize, Clone)]
struct ProcessorsDataType {
    client: String,
    server: String,
}

impl ProcessorsDataType {
    fn convert_maven_to_path(&mut self, folder: &str) -> Result<()> {
        self.client = convert_maven_to_path(&self.client, Some(folder))?;
        self.server = convert_maven_to_path(&self.server, Some(folder))?;
        Ok(())
    }
}

#[derive(Debug, Serialize, Deserialize, Clone, PartialEq, Eq, PartialOrd, Ord, Hash)]
struct ForgeLibrary {
    downloads: Option<ForgeLibraryDownloadMetadata>,
    name: String,
    url: Option<String>,
    include_in_classpath: bool,
}

#[derive(Debug, Serialize, Deserialize, Clone, PartialEq, Eq, PartialOrd, Ord, Hash)]
struct ForgeLibraryDownloadMetadata {
    artifact: ForgeLibraryArtifact,
}

#[derive(Debug, Serialize, Deserialize, Clone, PartialEq, Eq, PartialOrd, Ord, Hash)]
struct ForgeLibraryArtifact {
    path: String,
    sha1: String,
    size: usize,
    url: String,
}

#[derive(Debug, Serialize, Deserialize, Clone)]
#[serde(rename_all = "camelCase")]
struct ForgeVersionsManifest {
    game_versions: Vec<ForgeVersion>,
}

#[derive(Debug, Serialize, Deserialize, Clone)]
struct ForgeVersion {
    id: String,
    stable: bool,
    loaders: Vec<ForgeLoaders>,
}
#[derive(Debug, Serialize, Deserialize, Clone)]
struct ForgeLoaders {
    id: String,
    url: String,
    stable: bool,
}

async fn fetch_forge_manifest(game_version: &str, forge_version: Option<&str>) -> Result<Bytes> {
    let bytes = download_file("https://meta.modrinth.com/neo/v0/manifest.json", None).await?;
    let forge_manifest: ForgeVersionsManifest = serde_json::from_slice(&bytes)?;
    let loaders = &forge_manifest
        .game_versions
        .iter()
        .find(|x| x.id == game_version)
        .context("Can't find the desired game version")?
        .loaders;
    let loader_url = &match forge_version {
        Some(x) => loaders.iter().find(|y| y.id == x),
        None => loaders.first(),
    }
    .context("Can't find the forge manifest")?
    .url;
    download_file(&loader_url, None).await
}

pub async fn prepare_forge_download<'a>(
    mut launch_args: LaunchArgs,
    jvm_options: JvmOptions,
    game_options: GameOptions,
) -> Result<(DownloadArgs<'a>, ProcessedArguments, Value)> {
    let bytes = fetch_forge_manifest(&game_options.game_version_name, None).await?;

    let current_size = Arc::new(AtomicUsize::new(0));
    let total_size = Arc::new(AtomicUsize::new(0));

    let forge_manifest: Value = serde_json::from_slice(&bytes)?;
    let libraries: Vec<ForgeLibrary> = Vec::<ForgeLibrary>::deserialize(
        forge_manifest
            .get("libraries")
            .context("forge library key doesn't exist")?,
    )?;

    let mut handles: HandlesType = Vec::new();
    let mut classpath = HashSet::new();
    let library_directory = &jvm_options.library_directory;

    for library in libraries {
        if let Some(download) = library.downloads {
            let current_size_clone = Arc::clone(&current_size);
            let total_size_clone = Arc::clone(&total_size);
            let artifact = download.artifact;
            let path = library_directory.join(artifact.path.clone());
            let url = artifact.url.clone();
            let sha1 = artifact.sha1.clone();

            if library.include_in_classpath {
                classpath.insert(path.to_string_lossy().to_string());
            }

            handles.push(Box::pin(async move {
                if !path.exists() {
                    fs::create_dir_all(path.parent().context("forge library path doesn't exist")?)
                        .await?;
                    total_size_clone.fetch_add(artifact.size, Ordering::Relaxed);
                    let bytes = download_file(&url, Some(current_size_clone)).await?;
                    fs::write(path, bytes).await.map_err(|err| anyhow!(err))
                } else if let Err(err) = validate_sha1(&path, &sha1).await {
                    total_size_clone.fetch_add(artifact.size, Ordering::Relaxed);
                    error!("{err}\n redownloading");
                    let bytes = download_file(&url, Some(current_size_clone)).await?;
                    fs::write(path, bytes).await.map_err(|err| anyhow!(err))
                } else {
                    debug!("hash verified");
                    Ok(())
                }
            }));
        } else {
            let name = convert_maven_to_path(&library.name, None)?;
            let url = library.url.context("url doesn't exist")? + &name;
            let path = library_directory.join(name);

            if library.include_in_classpath {
                classpath.insert(path.to_string_lossy().to_string());
            }

            if !path.exists() {
                handles.push(Box::pin(async move {
                    fs::create_dir_all(path.parent().context("library parent dir doesn't exist")?)
                        .await?;
                    let bytes = download_file(&url, None).await?;
                    fs::write(path, bytes).await.map_err(|err| anyhow!(err))
                }));
            }
        }
    }

    let pos = launch_args.jvm_args.iter().position(|x| x == "-cp");
    if let Some(pos) = pos {
        let classpaths = launch_args
            .jvm_args
            .get_mut(pos + 1)
            .context("the next argument of -cp doesn't exist")?;
        let mut a = classpaths
            .split(':')
            .map(ToString::to_string)
            .collect::<HashSet<_>>();
        a.extend(classpath);
        *classpaths = a.into_iter().collect::<Vec<_>>().join(":");
    }

    Ok((
        DownloadArgs {
            current: Arc::clone(&current_size),
            total: Arc::clone(&total_size),
            handles,
            is_size: true,
        },
        ProcessedArguments {
            launch_args,
            jvm_args: jvm_options,
            game_args: game_options,
        },
        forge_manifest,
    ))
}

pub async fn process_forge<'a>(
    mut launch_args: LaunchArgs,
    jvm_options: JvmOptions,
    game_options: GameOptions,
    game_manifest: GameManifest,
    manifest: Value,
) -> Result<(LaunchArgs, DownloadArgs<'a>)> {
    let mut data = ProcessorData::deserialize(
        manifest
            .get("data")
            .context("forge manifest data doesn't exist")?,
    )?;
    let processors = Vec::<Processors>::deserialize(
        manifest
            .get("processors")
            .context("forge manifest processors doensn't exist")?,
    )?;
    let libraries_folder = jvm_options.library_directory.to_string_lossy().to_string();
    let library_manifest = Vec::<ForgeLibrary>::deserialize(
        manifest
            .get("libraries")
            .context("forge manifest library doesn't exist")?,
    )?;
    let forge_installer = library_manifest
        .iter()
        .filter(|x| x.downloads.is_none())
        .find(|x| x.name.contains("client"))
        .context("client installer doesn't exist")?
        .name
        .clone();
    let minecraft_jar = jvm_options.primary_jar.clone();
    let game_directory = jvm_options.game_directory.to_string_lossy().to_string();
    data.merged_mappings
        .convert_maven_to_path(&libraries_folder)?;
    data.mappings.convert_maven_to_path(&libraries_folder)?;
    data.mc_extra
        .as_mut()
        .map(|x| x.convert_maven_to_path(&libraries_folder));
    data.mc_slim
        .as_mut()
        .map(|x| x.convert_maven_to_path(&libraries_folder));
    data.mc_srg.convert_maven_to_path(&libraries_folder)?;
    data.mc_unpacked.convert_maven_to_path(&libraries_folder)?;
    data.mojmaps.convert_maven_to_path(&libraries_folder)?;
    data.patched.convert_maven_to_path(&libraries_folder)?;
    data.binpatch.convert_maven_to_path(&libraries_folder)?;
    let index = Arc::new(AtomicUsize::new(0));
    let index_cloned = Arc::clone(&index);
    let max = Arc::new(AtomicUsize::new(processors.len()));
    let mut handles: HandlesType = Vec::new();

    handles.push(Box::pin(async move {
        for (i, processor) in processors.into_iter().enumerate() {
            index_cloned.store(i, Ordering::Relaxed);
            let processor_jar = convert_maven_to_path(&processor.jar, Some(&libraries_folder))?;
            let processor_main_class = get_processor_main_class(processor_jar.clone())
                .await?
                .context("Processor main class doesn't exist")?;
            let mut processor_classpath = processor
                .classpath
                .iter()
                .map(|x| {
                    convert_maven_to_path(x, Some(&libraries_folder))
                        .context("failed to convert processor classpath maven to path")
                })
                .collect::<Result<Vec<_>>>()?;

            processor_classpath.push(processor_jar);

            if let Some(sides) = processor.sides {
                if sides.contains(&String::from("server")) {
                    continue;
                }
            }

            let args = process_client(
                &processor.args,
                &data,
                &minecraft_jar,
                &game_directory,
                &convert_maven_to_path(&forge_installer, Some(&libraries_folder))?,
            )
            .into_iter()
            .map(|x| {
                if x.starts_with('[') {
                    convert_maven_to_path(&x, Some(&libraries_folder))
                        .context("failed to convert [] types maven into path")
                } else {
                    Ok(x)
                }
            })
            .collect::<Result<Vec<_>>>()?;

            let mut all = Vec::new();
            all.push(String::from("-cp"));
            all.push(processor_classpath.join(":"));
            all.push(processor_main_class);
            all.extend(args);

            let process = tokio::process::Command::new("java")
                .args(all)
                .stdout(Stdio::piped())
                .stderr(Stdio::piped())
                .spawn()?
                .stdout
                .context("stdout doesn't exist")?;
            let read = tokio::io::BufReader::new(process);
            let mut a = read.lines();
            while let Some(x) = a.next_line().await? {
                debug!("{x}");
            }
        }
        Ok(())
    }));

    let arguments = manifest
        .get("arguments")
        .context("forge arguments doesn't exist")?;
    let jvm = Vec::<String>::deserialize(
        arguments
            .get("jvm")
            .context("jvm game flags doesn't exist")?,
    )?;
    let game = Vec::<String>::deserialize(
        arguments
            .get("game")
            .context("forge game flags doesn't exist")?,
    )?;
    let jvm = jvm_args_parse(&jvm, &jvm_options);
    launch_args.main_class = manifest
        .get("mainClass")
        .context("failed to get mainClass of Forge")?
        .as_str()
        .context("forge mainClass doesn't existing")?
        .to_owned();
    launch_args.jvm_args.extend(jvm);
    launch_args.game_args.extend(game);
    let download_args = DownloadArgs {
        current: index,
        total: max,
        handles,
        is_size: false,
    };
    Ok((launch_args, download_args))
}

fn jvm_args_parse(jvm_flags: &[String], jvm_options: &JvmOptions) -> Vec<String> {
    let mut parsed_argument = Vec::new();

    for argument in jvm_flags {
        let mut s = argument.as_str();
        let mut buf = String::with_capacity(s.len());

        while let Some(pos) = s.find("${") {
            buf.push_str(&s[..pos]);
            let start = &s[pos + 2..];

            let Some(closing) = start.find('}') else {
                panic!("missing closing brace");
            };
            let var = &start[..closing];
            // make processing string to next part
            s = &start[closing + 1..];

            let library = jvm_options.library_directory.to_string_lossy().to_string();

            let primary_jar_path = PathBuf::from(&jvm_options.primary_jar);
            let primary_jar = primary_jar_path
                .file_stem()
                .expect("can't find file_stem of primary jar")
                .to_string_lossy()
                .to_string();

            buf.push_str(match var {
                "library_directory" => &library,
                "classpath_separator" => &jvm_options.classpath_separator,
                "version_name" => &primary_jar,
                x => {
                    warn!("{x} is not processed, please notify the developer");
                    x
                }
            });
        }
        buf.push_str(s);
        parsed_argument.push(buf);
    }
    parsed_argument
}

fn process_client(
    jvm_flags: &[String],
    processors_data: &ProcessorData,
    minecraft_jar: &str,
    root: &str,
    installer: &str,
) -> Vec<String> {
    let mut parsed_argument = Vec::new();

    for argument in jvm_flags {
        let mut s = argument.as_str();
        let mut buf = String::with_capacity(s.len());

        while let Some(pos) = s.find('{') {
            buf.push_str(&s[..pos]);
            let start = &s[pos + 1..];

            let Some(closing) = start.find('}') else {
                panic!("missing closing brace");
            };
            let var = &start[..closing];
            // make processing string to next part
            s = &start[closing + 1..];

            buf.push_str(match var {
                "MERGED_MAPPINGS" => processors_data.merged_mappings.client.as_str(),
                "MAPPINGS" => processors_data.mappings.client.as_str(),
                "MC_EXTRA" => processors_data.mc_extra.as_ref().unwrap().client.as_str(),
                "MC_EXTRA_SHA" => processors_data
                    .mc_extra_sha
                    .as_ref()
                    .unwrap()
                    .client
                    .as_str(),
                "MC_SLIM" => processors_data.mc_slim.as_ref().unwrap().client.as_str(),
                "MC_SLIM_SHA" => processors_data
                    .mc_slim_sha
                    .as_ref()
                    .unwrap()
                    .client
                    .as_str(),
                "MC_SRG" => processors_data.mc_srg.client.as_str(),
                "MC_UNPACKED" => processors_data.mc_unpacked.client.as_str(),
                "MOJMAPS" => processors_data.mojmaps.client.as_str(),
                "PATCHED" => processors_data.patched.client.as_str(),
                "PATCHED_SHA" => processors_data
                    .patched_sha
                    .as_ref()
                    .unwrap()
                    .client
                    .as_str(),
                "BINPATCH" => processors_data.binpatch.client.as_str(),
                "MCP_VERSION" => processors_data
                    .mcp_version
                    .as_ref()
                    .unwrap()
                    .client
                    .as_str(),
                "MINECRAFT_JAR" => minecraft_jar,
                "ROOT" => root,
                "INSTALLER" => installer,
                "SIDE" => "client",
                _ => "",
            });
        }
        buf.push_str(s);
        parsed_argument.push(buf);
    }
    parsed_argument
}

fn pre_convert_maven_to_path(input: &str, extension: Option<&str>) -> Result<String> {
    let parts: Vec<&str> = input.split(':').collect();
    let org = parts
        .first()
        .context("failed to got org from maven")?
        .replace('.', "/");
    let package = parts[1];
    let path_version = parts[2];
    let mut version = parts[2].to_owned();
    if let Some(x) = parts.get(3) {
        version.push_str(format!("-{x}").as_str());
    }
    if let Some(x) = parts.get(4) {
        version.push_str(format!("-{x}").as_str());
    }
    let extension = extension.unwrap_or("jar");
    let file_name = format!("{package}-{version}.{extension}");
    let path = format!("{org}/{package}/{path_version}");

    Ok(format!("{path}/{file_name}"))
}

pub fn convert_maven_to_path(str: &str, folder: Option<&str>) -> Result<String> {
    let pos = str.find(|x| x == '@');
    let mut pre_maven = pos.map_or_else(
        || pre_convert_maven_to_path(str, None),
        |position| pre_convert_maven_to_path(&str[..position], Some(&str[position + 1..])),
    )?;
    pre_maven.retain(|x| x != '[' && x != ']');
    if let Some(folder) = folder {
        pre_maven.insert_str(0, format!("{folder}/").as_str());
    }
    Ok(pre_maven)
}

pub async fn get_processor_main_class(path: String) -> Result<Option<String>> {
    let zipfile = tokio::fs::File::open(&path)
        .await
        .context(path)?
        .into_std()
        .await;
    let mut archive = zip::ZipArchive::new(zipfile)?;

    let file = archive.by_name("META-INF/MANIFEST.MF")?;

    let reader = BufReader::new(file);

    for line in reader.lines() {
        let mut line = line?;
        line.retain(|c| !c.is_whitespace());

        if line.starts_with("Main-Class:") {
            if let Some(class) = line.split(':').nth(1) {
                return Ok(Some(class.to_owned()));
            }
        }
    }
    Ok(None)
}
