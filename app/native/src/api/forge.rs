use std::{
    io::{BufRead, BufReader},
    path::PathBuf,
    process::Stdio,
    sync::{
        atomic::{AtomicUsize, Ordering},
        Arc,
    },
};

use anyhow::{anyhow, bail, Context, Result};
use log::{debug, error, warn};
use serde::{Deserialize, Serialize};
use serde_json::Value;
use tokio::{fs, io::AsyncBufReadExt};

use super::{
    download::{download_file, extract_filename, validate_sha1, DownloadArgs},
    vanilla::{
        get_global_shared_path, manifest::GameManifest, GameOptions, HandlesType, JvmOptions,
        LaunchArgs, ProcessedArguments,
    },
};
#[derive(Debug, Serialize, Deserialize, Clone)]
struct Processors {
    jar: String,
    classpath: Vec<String>,
    args: Vec<String>,
    sides: Option<Vec<String>>,
}
#[derive(Debug, Serialize, Deserialize, Clone)]
#[serde(rename_all = "SCREAMING_SNAKE_CASE")]
struct ProcessorData {
    merged_mappings: ProcessorsDataType,
    mappings: ProcessorsDataType,
    mc_extra: ProcessorsDataType,
    mc_extra_sha: ProcessorsDataType,
    mc_slim: ProcessorsDataType,
    mc_slim_sha: ProcessorsDataType,
    mc_unpacked: ProcessorsDataType,
    mc_srg: ProcessorsDataType,
    mcp_version: ProcessorsDataType,
    mojmaps: ProcessorsDataType,
    patched: ProcessorsDataType,
    patched_sha: ProcessorsDataType,
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

#[derive(Debug, Serialize, Deserialize, Clone)]
struct ForgeLibrary {
    downloads: Option<ForgeLibraryDownloadMetadata>,
    name: String,
    url: Option<String>,
    include_in_classpath: bool,
}

#[derive(Debug, Serialize, Deserialize, Clone)]
struct ForgeLibraryDownloadMetadata {
    artifact: ForgeLibraryArtifact,
}

#[derive(Debug, Serialize, Deserialize, Clone)]
struct ForgeLibraryArtifact {
    path: String,
    sha1: String,
    size: usize,
    url: String,
}

pub async fn prepare_forge_download<'a>(
    mut launch_args: LaunchArgs,
    jvm_options: JvmOptions,
    game_options: GameOptions,
) -> Result<(DownloadArgs<'a>, ProcessedArguments, Value)> {
    // NOTE: blah blah
    let bytes = download_file(
        "https://meta.modrinth.com/forge/v0/versions/1.20.2-forge-48.0.13.json",
        None,
    )
    .await?;
    let current_size = Arc::new(AtomicUsize::new(0));
    let total_size = Arc::new(AtomicUsize::new(0));
    let forge_manifest: Value = serde_json::from_slice(&bytes)?;
    let libraries: Vec<ForgeLibrary> = Vec::<ForgeLibrary>::deserialize(
        forge_manifest
            .get("libraries")
            .context("forge library key doesn't exist")?,
    )?;
    // NOTE: rust can't dedcue the type here(cause dyn trait)
    let mut handles: HandlesType = Vec::new();
    let mut classpath = Vec::new();
    let library_directory = &jvm_options.library_directory;

    for library in libraries {
        if let Some(download) = library.downloads {
            let current_size_clone = Arc::clone(&current_size);
            let total_size_clone = Arc::clone(&total_size);
            let artifact = download.artifact;
            let path = library_directory.join(artifact.path);
            let url = artifact.url;
            let sha1 = artifact.sha1;

            if library.include_in_classpath {
                classpath.push(path.to_string_lossy().to_string());
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
                classpath.push(path.to_string_lossy().to_string());
            }

            handles.push(Box::pin(async move {
                if path.exists() {
                    Ok(())
                } else {
                    fs::create_dir_all(path.parent().context("library parent dir doesn't exist")?)
                        .await?;
                    let bytes = download_file(&url, None).await?;
                    fs::write(path, bytes).await.map_err(|err| anyhow!(err))
                }
            }));
        }
    }

    let pos = launch_args.jvm_args.iter().position(|x| x == "-cp");
    if let Some(pos) = pos {
        let classpaths = launch_args
            .jvm_args
            .get_mut(pos + 1)
            .context("the next argument of -cp doesn't exist")?;
        classpaths.push(':');
        classpaths.push_str(classpath.join(":").as_str());
    }

    Ok((
        DownloadArgs {
            current_size: Arc::clone(&current_size),
            total_size: Arc::clone(&total_size),
            handles,
        },
        ProcessedArguments {
            launch_args,
            jvm_args: jvm_options,
            game_args: game_options,
        },
        forge_manifest,
    ))
}

pub async fn process_forge(
    mut launch_args: LaunchArgs,
    jvm_options: JvmOptions,
    game_options: GameOptions,
    game_manifest: GameManifest,
    manifest: Value,
) -> Result<LaunchArgs> {
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
    let folder = jvm_options.library_directory.to_string_lossy().to_string();
    let library_manifest = Vec::<ForgeLibrary>::deserialize(
        manifest
            .get("libraries")
            .context("forge manifest library doesn't exist")?,
    )?;
    let forge_installer = library_manifest
        .iter()
        .filter(|x| x.downloads.is_none())
        .nth(1)
        .context("client installer doesn't exist")?
        .name
        .as_str();
    data.merged_mappings.convert_maven_to_path(&folder)?;
    data.mappings.convert_maven_to_path(&folder)?;
    data.mc_extra.convert_maven_to_path(&folder)?;
    data.mc_slim.convert_maven_to_path(&folder)?;
    data.mc_srg.convert_maven_to_path(&folder)?;
    data.mc_unpacked.convert_maven_to_path(&folder)?;
    data.mojmaps.convert_maven_to_path(&folder)?;
    data.patched.convert_maven_to_path(&folder)?;
    data.binpatch.convert_maven_to_path(&folder)?;

    for processor in processors {
        let jar = convert_maven_to_path(&processor.jar, Some(&folder))?;
        let processor_main_class = get_processor_main_class(jar.clone())
            .await?
            .context("Processor main class doesn't exist")?;
        let mut processor_classpath = processor
            .classpath
            .iter()
            .map(|x| {
                convert_maven_to_path(x, Some(&folder))
                    .context("failed to convert processor classpath maven to path")
            })
            .collect::<Result<Vec<_>>>()?;
        processor_classpath.push(jar);
        let minecraft_jar;
        let side;
        if let Some(sides) = processor.sides {
            match sides.get(0) {
                Some(x) if x == "server" => {
                    let shared_path = get_global_shared_path();
                    let version_id = &game_options.game_version_name;
                    let version_directory = shared_path.join(format!("versions/{version_id}"));
                    let url = &game_manifest.downloads.server.url;
                    let path = version_directory.join(extract_filename(url)?);
                    if !path.exists() {
                        fs::create_dir_all(
                            path.parent()
                                .context("failed to get parent dir of server jar")?,
                        )
                        .await?;
                        let bytes = download_file(url, None).await?;
                        fs::write(&path, bytes).await.map_err(|err| anyhow!(err))?;
                    }
                    side = x.to_string();
                    minecraft_jar = path.to_string_lossy().to_string();
                }
                Some(x) if x == "client" => {
                    side = x.to_string();
                    minecraft_jar = jvm_options.primary_jar.clone();
                }
                None | Some(_) => bail!("Somehow the sides exists but its empty????"),
            };
        } else {
            minecraft_jar = String::new();
            side = String::from("client");
        }
        let args = process_client(
            &processor.args,
            &data,
            &minecraft_jar,
            &jvm_options.game_directory.to_string_lossy(),
            &convert_maven_to_path(forge_installer, Some(&folder))?,
            &side,
        )
        .into_iter()
        .map(|x| {
            convert_maven_to_path(&x, Some(&folder))
                .context("failed to convert [] types maven into path")
        })
        .collect::<Result<Vec<_>>>()?;
        let mut all = Vec::new();
        all.push(String::from("-cp"));
        all.push(processor_classpath.join(":"));
        all.push(processor_main_class.clone());
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
    Ok(launch_args)
}

fn jvm_args_parse(jvm_flags: &[String], jvm_options: &JvmOptions) -> Vec<String> {
    let mut parsed_argument = Vec::new();

    for argument in jvm_flags.iter() {
        let mut s = argument.as_str();
        let mut buf = String::with_capacity(s.len());

        while let Some(pos) = s.find("${") {
            buf.push_str(&s[..pos]);
            let start = &s[pos + 2..];

            let Some(closing) = start.find('}') else { panic!("missing closing brace"); };
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
    sides: &str,
) -> Vec<String> {
    let mut parsed_argument = Vec::new();

    for argument in jvm_flags.iter() {
        let mut s = argument.as_str();
        let mut buf = String::with_capacity(s.len());

        while let Some(pos) = s.find('{') {
            buf.push_str(&s[..pos]);
            let start = &s[pos + 1..];

            let Some(closing) = start.find('}') else { panic!("missing closing brace"); };
            let var = &start[..closing];
            // make processing string to next part
            s = &start[closing + 1..];

            if sides == "client" {
                buf.push_str(match var {
                    "MERGED_MAPPINGS" => processors_data.merged_mappings.client.as_str(),
                    "MAPPINGS" => processors_data.mappings.client.as_str(),
                    "MC_EXTRA" => processors_data.mc_extra.client.as_str(),
                    "MC_EXTRA_SHA" => processors_data.mc_extra_sha.client.as_str(),
                    "MC_SLIM" => processors_data.mc_slim.client.as_str(),
                    "MC_SLIM_SHA" => processors_data.mc_slim_sha.client.as_str(),
                    "MC_SRG" => processors_data.mc_srg.client.as_str(),
                    "MC_UNPACKED" => processors_data.mc_unpacked.client.as_str(),
                    "MOJMAPS" => processors_data.mojmaps.client.as_str(),
                    "PATCHED" => processors_data.patched.client.as_str(),
                    "PATCHED_SHA" => processors_data.patched_sha.client.as_str(),
                    "BINPATCH" => processors_data.binpatch.client.as_str(),
                    "MCP_VERSION" => processors_data.mcp_version.client.as_str(),
                    "MINECRAFT_JAR" => minecraft_jar,
                    "ROOT" => root,
                    "INSTALLER" => installer,
                    "SIDE" => "client",
                    _ => "",
                });
            } else if sides == "server" {
                buf.push_str(match var {
                    "MERGED_MAPPINGS" => processors_data.merged_mappings.server.as_str(),
                    "MAPPINGS" => processors_data.mappings.server.as_str(),
                    "MC_EXTRA" => processors_data.mc_extra.server.as_str(),
                    "MC_EXTRA_SHA" => processors_data.mc_extra_sha.server.as_str(),
                    "MC_SLIM" => processors_data.mc_slim.server.as_str(),
                    "MC_SLIM_SHA" => processors_data.mc_slim_sha.server.as_str(),
                    "MC_SRG" => processors_data.mc_srg.server.as_str(),
                    "MC_UNPACKED" => processors_data.mc_unpacked.server.as_str(),
                    "MOJMAPS" => processors_data.mojmaps.server.as_str(),
                    "PATCHED" => processors_data.patched.server.as_str(),
                    "PATCHED_SHA" => processors_data.patched_sha.server.as_str(),
                    "BINPATCH" => processors_data.binpatch.server.as_str(),
                    "MCP_VERSION" => processors_data.mcp_version.server.as_str(),
                    "MINECRAFT_JAR" => minecraft_jar,
                    "ROOT" => root,
                    "INSTALLER" => installer,
                    "SIDE" => "client",
                    _ => "",
                });
            }
        }
        buf.push_str(s);
        parsed_argument.push(buf);
    }
    parsed_argument
}

pub fn pre_convert_maven_to_path(input: &str, extension: Option<&str>) -> Result<String> {
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
    let extension = extension.unwrap_or("jar");
    let file_name = format!("{package}-{version}.{extension}");
    let path = format!("{org}/{package}/{path_version}");

    Ok(format!("{path}/{file_name}"))
}

fn convert_maven_to_path(str: &str, folder: Option<&str>) -> Result<String> {
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
