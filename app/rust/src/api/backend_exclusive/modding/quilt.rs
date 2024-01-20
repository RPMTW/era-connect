use std::sync::{atomic::AtomicUsize, Arc};

use anyhow::{anyhow, Context, Result};
use log::info;
use serde::{Deserialize, Serialize};
use serde_json::Value;
use tokio::{
    fs::{self, File},
    io::AsyncReadExt,
};

use crate::api::{
    backend_exclusive::{
        download::{
            download_file, execute_and_progress, validate_sha1, DownloadArgs, DownloadBias,
            HandlesType,
        },
        vanilla::{
            launcher::{
                prepare_vanilla_download, GameOptions, JvmOptions, LaunchArgs, ProcessedArguments,
            },
            manifest::fetch_game_manifest,
        },
    },
    shared_resources::collection::Collection,
};

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct QuiltLibrary {
    name: String,
    url: String,
}

pub async fn prepare_quilt_download<'a>(
    launch_args: LaunchArgs,
    jvm_options: JvmOptions,
    game_options: GameOptions,
) -> Result<(DownloadArgs<'a>, ProcessedArguments)> {
    let game_version = &game_options.game_version_name;
    let meta_url = format!("https://meta.quiltmc.org/v3/versions/loader/{game_version}");
    let bytes = download_file(&meta_url, None).await?;
    let version_manifest: Value = serde_json::from_slice(&bytes)?;
    let current_size = Arc::new(AtomicUsize::new(0));
    let total_size = Arc::new(AtomicUsize::new(0));

    let mut download_list = Vec::<QuiltLibrary>::deserialize(
        &version_manifest[0]["launcherMeta"]["libraries"]["common"],
    )?;

    let quilt_loader_list = version_manifest[0]
        .as_object()
        .context("quilt loader list is not object")?;
    let quilt_loader_types = vec!["loader", "hashed", "intermediary"];
    for loader_type in quilt_loader_types {
        let maven = quilt_loader_list
            .get(loader_type)
            .and_then(|x| x.get("maven").and_then(Value::as_str))
            .context("quilt maven is not a string!")?;

        download_list.push(QuiltLibrary {
            name: maven.to_owned(),
            url: if maven.contains("quiltmc") {
                "https://maven.quiltmc.org/repository/release/"
            } else {
                "https://maven.fabricmc.net/"
            }
            .to_owned(),
        });
    }

    let library_directory = jvm_options.library_directory.clone();

    let path_vec = download_list
        .iter()
        .map(|x| library_directory.join(convert_maven_to_path(&x.name)))
        .collect::<Vec<_>>();
    let url_vec = download_list
        .iter()
        .map(|x| convert_maven_to_path(&x.name))
        .collect::<Vec<_>>();
    for x in &path_vec {
        fs::create_dir_all(
            x.parent()
                .context("can't find download_list parent's dir")?,
        )
        .await?;
    }

    let mut jvm_options = jvm_options;
    let mut launch_args = launch_args;

    // NOTE: easily forgetable `:`
    jvm_options.classpath.push(':');
    jvm_options.classpath.push_str(
        &path_vec
            .iter()
            .map(|x| x.to_string_lossy().to_string())
            .collect::<Vec<_>>()
            .join(":"),
    );
    if let Some(classpath_position) = launch_args.jvm_args.iter().position(|x| x == "-cp") {
        launch_args.jvm_args[classpath_position + 1] = jvm_options.classpath.clone();
    }
    launch_args.main_class = version_manifest[0]["launcherMeta"]["mainClass"]["client"]
        .as_str()
        .context("fail to get quilt mainclass")?
        .to_owned();

    // NOTE: rust can't dedcue the type here(cause dyn trait)
    let mut handles: HandlesType = Vec::new();

    for ((library, path), url) in download_list
        .into_iter()
        .zip(path_vec.into_iter())
        .zip(url_vec.into_iter())
    {
        let current_size_clone = Arc::clone(&current_size);
        handles.push(Box::pin(async move {
            let url = format!("{}{}", library.url, url);
            let sha1_path = path.with_extension("jar.sha1");
            let sha1_url = url.clone() + ".sha1";
            let mut sha1 = String::new();
            if sha1_path.exists() {
                File::open(&sha1_path)
                    .await?
                    .read_to_string(&mut sha1)
                    .await?;
            } else {
                sha1 = String::from_utf8(
                    download_file(&sha1_url, Some(Arc::clone(&current_size_clone)))
                        .await?
                        .to_vec(),
                )?;
            }
            if !path.exists() {
                let bytes = download_file(&url, Some(current_size_clone)).await?;
                fs::write(&path, bytes).await.map_err(|err| anyhow!(err))
            } else if validate_sha1(&sha1_path, &sha1).await.is_err() {
                let bytes = download_file(&url, Some(current_size_clone)).await?;
                fs::write(&path, bytes).await.map_err(|err| anyhow!(err))
            } else {
                Ok(())
            }
        }));
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
    ))
}

pub async fn full_quilt_download(collection: &Collection) -> anyhow::Result<LaunchArgs> {
    let collection_id = collection.get_collection_id();
    info!("Starts Vanilla Downloading");
    let vanilla_bias = DownloadBias {
        start: 0.0,
        end: 80.0,
    };
    let game_manifest = fetch_game_manifest(&collection.minecraft_version.url).await?;
    let (vanilla_download_args, vanilla_arguments) =
        prepare_vanilla_download(collection, game_manifest.clone()).await?;
    execute_and_progress(collection_id.clone(), vanilla_download_args, vanilla_bias).await?;

    info!("Starts Quilt Downloading");
    let quilt_download_bias = DownloadBias {
        start: 90.0,
        end: 100.0,
    };

    let (quilt_download_args, processed_arguments) = prepare_quilt_download(
        vanilla_arguments.launch_args,
        vanilla_arguments.jvm_args,
        vanilla_arguments.game_args,
    )
    .await?;
    execute_and_progress(
        collection_id.clone(),
        quilt_download_args,
        quilt_download_bias,
    )
    .await?;

    Ok(processed_arguments.launch_args)
}

fn convert_maven_to_path(input: &str) -> String {
    let parts: Vec<&str> = input.split(':').collect();
    let org = parts[0].replace('.', "/");
    let package = parts[1];
    let version = parts[2];
    let file_name = format!("{package}-{version}.jar");
    let path = format!("{org}/{package}/{version}");

    format!("{path}/{file_name}")
}
