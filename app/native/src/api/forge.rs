use std::{
    io::{BufRead, BufReader},
    path::PathBuf,
    process::Command,
    sync::{
        atomic::{AtomicUsize, Ordering},
        Arc,
    },
};

use anyhow::{anyhow, bail, Context, Result};
use serde::{Deserialize, Serialize};
use serde_json::Value;
use tokio::fs;

use super::{
    download::util::{download_file, extract_filename, validate_sha1},
    vanilla::{get_game_manifest, HandlesType, ProcessedArguments},
    DownloadArgs, GameOptions, JvmOptions, LaunchArgs,
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
    fn convert_maven_to_path(&mut self, folder: &str) {
        self.client = convert_maven_to_path(&self.client, Some(folder));
        self.server = convert_maven_to_path(&self.server, Some(folder));
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

pub async fn prepare_forge_download(
    mut launch_args: LaunchArgs,
    jvm_options: JvmOptions,
    game_options: GameOptions,
) -> Result<(DownloadArgs, ProcessedArguments, Value)> {
    // refactor
    let bytes = download_file(
        "https://meta.modrinth.com/forge/v0/versions/1.20.1-forge-47.1.43.json".to_string(),
        None,
    )
    .await?;
    let current_size = Arc::new(AtomicUsize::new(0));
    let total_size = Arc::new(AtomicUsize::new(0));
    let forge_manifest: Value = serde_json::from_slice(&bytes)?;
    let libraries: Vec<ForgeLibrary> =
        Vec::<ForgeLibrary>::deserialize(&forge_manifest["libraries"])?;
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
                    fs::create_dir_all(path.parent().unwrap()).await?;
                    total_size_clone.fetch_add(artifact.size, Ordering::Relaxed);
                    let bytes = download_file(url, Some(current_size_clone)).await?;
                    fs::write(path, bytes).await.map_err(|err| anyhow!(err))
                } else if let Err(err) = validate_sha1(&path, &sha1).await {
                    total_size_clone.fetch_add(artifact.size, Ordering::Relaxed);
                    eprintln!("{err}");
                    let bytes = download_file(url, Some(current_size_clone)).await?;
                    fs::write(path, bytes).await.map_err(|err| anyhow!(err))
                } else {
                    println!("hash verified");
                    Ok(())
                }
            }));
        } else {
            let name = convert_maven_to_path(&library.name, None);
            let url = library.url.unwrap() + &name;
            let path = library_directory.join(name);

            if library.include_in_classpath {
                classpath.push(path.to_string_lossy().to_string());
            }

            handles.push(Box::pin(async move {
                if path.exists() {
                    Ok(())
                } else {
                    fs::create_dir_all(path.parent().unwrap()).await?;
                    let bytes = download_file(url, None).await?;
                    fs::write(path, bytes).await.map_err(|err| anyhow!(err))
                }
            }));
        }
    }

    let pos = launch_args.jvm_args.iter().position(|x| x == "-cp");
    if let Some(pos) = pos {
        let classpaths = launch_args.jvm_args.get_mut(pos + 1).unwrap();
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
    _game_options: GameOptions,
    manifest: Value,
) -> Result<LaunchArgs> {
    let mut data = ProcessorData::deserialize(&manifest["data"])?;
    let processors = Vec::<Processors>::deserialize(&manifest["processors"])?;
    let folder = jvm_options.library_directory.to_string_lossy().to_string();
    let library_manifest = Vec::<ForgeLibrary>::deserialize(&manifest["libraries"])?;
    let forge_installer = library_manifest
        .iter()
        .filter(|x| x.downloads.is_none())
        .nth(1)
        .unwrap()
        .name
        .as_str();
    data.merged_mappings.convert_maven_to_path(&folder);
    data.mappings.convert_maven_to_path(&folder);
    data.mc_extra.convert_maven_to_path(&folder);
    data.merged_mappings.client =
        convert_maven_to_path(&data.merged_mappings.client, Some(&folder));
    data.mappings.client = convert_maven_to_path(&data.mappings.client, Some(&folder));
    data.mc_extra.convert_maven_to_path(&folder);
    data.mc_slim.convert_maven_to_path(&folder);
    data.mc_srg.convert_maven_to_path(&folder);
    data.mc_unpacked.convert_maven_to_path(&folder);
    data.mojmaps.convert_maven_to_path(&folder);
    data.patched.convert_maven_to_path(&folder);
    data.binpatch.convert_maven_to_path(&folder);
    let (game_manifest, _) = get_game_manifest(
        "https://launchermeta.mojang.com/mc/game/version_manifest.json".to_string(),
        None,
    )
    .await?;
    for processor in processors {
        let jar = convert_maven_to_path(&processor.jar, Some(&folder));
        let processor_main_class = get_processor_main_class(jar.clone())?.unwrap();
        let mut processor_classpath = processor
            .classpath
            .iter()
            .map(|x| convert_maven_to_path(x, Some(&folder)))
            .collect::<Vec<_>>();
        processor_classpath.push(jar.to_string());
        let mut minecraft_jar = String::new();
        let side;
        if let Some(sides) = processor.sides {
            minecraft_jar = match sides.get(0) {
                Some(x) if x == "server" => {
                    let url = game_manifest["downloads"]["server"]["url"]
                        .as_str()
                        .unwrap();
                    let path = std::env::current_dir()?.join(extract_filename(url)?);
                    if !path.exists() {
                        fs::create_dir_all(path.parent().unwrap()).await?;
                        let bytes = download_file(url.to_string(), None).await?;
                        fs::write(&path, bytes).await.map_err(|err| anyhow!(err))?;
                    }
                    side = x.to_string();
                    path.to_string_lossy().to_string()
                }
                Some(x) if x == "client" => {
                    side = x.to_string();
                    jvm_options.primary_jar.clone()
                }
                None | Some(_) => bail!("Somehow the sides existing but its empty????"),
            };
        } else {
            side = String::from("client");
        }
        let args = process_client(
            &processor.args,
            &data,
            &minecraft_jar,
            &jvm_options.game_directory.to_string_lossy(),
            &convert_maven_to_path(forge_installer, Some(&folder)),
            &side,
        )
        .into_iter()
        .map(|x| {
            if x.starts_with('[') {
                convert_maven_to_path(&x, Some(&folder))
            } else {
                x
            }
        })
        .collect::<Vec<_>>();
        let mut all = Vec::new();
        all.push("-cp".to_string());
        all.push(processor_classpath.join(":"));
        all.push(processor_main_class.clone());
        all.extend(args);

        Command::new("java").args(all).spawn()?.wait()?;
    }
    let jvm = Vec::<String>::deserialize(&manifest["arguments"]["jvm"])?;
    let game = Vec::<String>::deserialize(&manifest["arguments"]["game"])?;
    let jvm = jvm_args_parse(&jvm, &jvm_options);
    launch_args.main_class = manifest["mainClass"]
        .as_str()
        .context("forge mainClass doesn't existing")?
        .to_string();
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
                .context("f")
                .unwrap()
                .to_string_lossy()
                .to_string();

            buf.push_str(match var {
                "library_directory" => &library,
                "classpath_separator" => &jvm_options.classpath_separator,
                "version_name" => &primary_jar,
                x => dbg!(x),
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

pub fn pre_convert_maven_to_path(input: &str, extension: Option<&str>) -> String {
    let parts: Vec<&str> = input.split(':').collect();
    let org = parts[0].replace('.', "/");
    let package = parts[1];
    let path_version = parts[2];
    let mut version = parts[2].to_string();
    if let Some(x) = parts.get(3) {
        version.push_str(format!("-{x}").as_str());
    }
    let extension = extension.unwrap_or("jar");
    let file_name = format!("{package}-{version}.{extension}");
    let path = format!("{org}/{package}/{path_version}");

    format!("{path}/{file_name}")
}

fn convert_maven_to_path(str: &str, folder: Option<&str>) -> String {
    let pos = str.chars().position(|x| x == '@');
    let mut pre_maven = pos.map_or_else(
        || pre_convert_maven_to_path(str, None),
        |position| pre_convert_maven_to_path(&str[..position], Some(&str[position + 1..])),
    ); // HACK: hell why
    if let Some(folder) = folder {
        if pre_maven.starts_with('[') {
            pre_maven.insert_str(1, format!("{folder}/").as_str());
            pre_maven.remove(0);
        } else {
            pre_maven.insert_str(0, format!("{folder}/").as_str());
        }
    } else if pre_maven.starts_with('[') {
        pre_maven.remove(0);
    }
    if let Some(pos) = pre_maven.chars().position(|x| x == ']') {
        pre_maven.remove(pos);
    }
    pre_maven
}

pub fn get_processor_main_class(path: String) -> Result<Option<String>> {
    let zipfile = std::fs::File::open(&path).context(path)?;
    let mut archive = zip::ZipArchive::new(zipfile)?;

    let file = archive.by_name("META-INF/MANIFEST.MF")?;

    let reader = BufReader::new(file);

    for line in reader.lines() {
        let mut line = line?;
        line.retain(|c| !c.is_whitespace());

        if line.starts_with("Main-Class:") {
            if let Some(class) = line.split(':').nth(1) {
                return Ok(Some(class.to_string()));
            }
        }
    }
    Ok(None)
}
