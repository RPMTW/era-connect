use std::sync::{
    atomic::{AtomicUsize, Ordering},
    Arc,
};

use anyhow::{anyhow, Result};
use futures::stream::FuturesUnordered;
use serde::{Deserialize, Serialize};
use serde_json::Value;
use tokio::{
    fs::{self, File},
    io::AsyncReadExt,
};

use super::{
    download::util::{download_file, validate_sha1},
    DownloadArgs, GameArgs, JvmArgs, LaunchArgs,
};
#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct QuiltLibrary {
    name: String,
    url: String,
}

pub async fn prepare_quilt_download(
    game_version: String,
    launch_args: LaunchArgs,
    jvm_options: JvmArgs,
    game_options: GameArgs,
) -> Result<DownloadArgs> {
    let meta_url = format!("https://meta.quiltmc.org/v3/versions/loader/{game_version}");
    let response = reqwest::get(meta_url).await?;
    let version_manifest: Value = response.json().await?;
    let mut download_list = Vec::<QuiltLibrary>::deserialize(
        &version_manifest[0]["launcherMeta"]["libraries"]["common"],
    )?;

    let quilt_loader_list = version_manifest[0].as_object().unwrap();
    let quilt_loader_types = vec!["loader", "hashed", "intermediary"];
    for loader_type in quilt_loader_types {
        let maven = quilt_loader_list
            .get(loader_type)
            .ok_or_else(|| anyhow!("fail to get quilt_maven"))?
            .get("maven")
            .ok_or_else(|| anyhow!("fail to get quilt maven"))?
            .as_str()
            .ok_or_else(|| anyhow!("quilt maven is not a string!"))?;
        download_list.push(QuiltLibrary {
            name: maven.to_string(),
            url: if maven.contains("quiltmc") {
                "https://maven.quiltmc.org/repository/release/"
            } else {
                "https://maven.fabricmc.net/"
            }
            .to_string(),
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
        fs::create_dir_all(x.parent().unwrap()).await?;
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
        .ok_or_else(|| anyhow!("fail to get quilt mainclass"))?
        .to_string();

    let handles = FuturesUnordered::new();
    let index_counter = Arc::new(AtomicUsize::new(0));
    let current_size = Arc::new(AtomicUsize::new(0));
    let total_size = Arc::new(AtomicUsize::new(0));
    let num_libraries = download_list.len();
    let download_list_arc = Arc::new(download_list);

    let path_vec_arc = Arc::new(path_vec);
    let url_vec_arc = Arc::new(url_vec);
    for _ in 0..num_libraries {
        let url_vec_clone = Arc::clone(&url_vec_arc);
        let index_counter_clone = Arc::clone(&index_counter);
        let current_size_clone = Arc::clone(&current_size);
        let download_list_clone = Arc::clone(&download_list_arc);
        let path_vec_clone = Arc::clone(&path_vec_arc);
        handles.push(tokio::spawn(async move {
            let index = index_counter_clone.fetch_add(1, Ordering::SeqCst);

            if index < num_libraries {
                let library = &download_list_clone[index];
                let url = format!("{}{}", library.url, url_vec_clone[index]);
                let path = &path_vec_clone[index];
                let sha1_path = path.with_extension("jar.sha1");
                let sha1_url = url.clone() + ".sha1";
                download_file(sha1_url, Some(&sha1_path), Arc::clone(&current_size_clone)).await?;
                let mut sha1 = String::new();
                File::open(&sha1_path)
                    .await?
                    .read_to_string(&mut sha1)
                    .await?;
                if !path.exists() {
                    download_file(url, Some(path), current_size_clone).await
                } else if validate_sha1(&sha1_path, &sha1).await.is_err() {
                    download_file(url, Some(path), current_size_clone).await
                } else {
                    Ok(())
                }
            } else {
                Ok(())
            }
        }));
    }
    Ok(DownloadArgs {
        current_size: Arc::clone(&current_size),
        total_size: Arc::clone(&total_size),
        handles,
        launch_args,
        jvm_args: jvm_options,
        game_args: game_options,
    })
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
