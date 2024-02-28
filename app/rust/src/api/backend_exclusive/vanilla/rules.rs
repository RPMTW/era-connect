use anyhow::{anyhow, Context, Result};
use core::fmt;
use serde_json::Value;
use std::collections::HashMap;

use serde::{Deserialize, Serialize};

#[derive(Debug, PartialEq, Eq, Serialize, Deserialize, Clone)]
pub enum ActionType {
    #[serde(rename = "allow")]
    Allow,
    #[serde(rename = "disallow")]
    Disallow,
}

#[derive(Debug, PartialEq, Eq, Serialize, Deserialize, Clone, Copy)]
pub enum OsName {
    #[serde(rename = "osx")]
    Osx,
    #[serde(rename = "windows")]
    Windows,
    #[serde(rename = "linux")]
    Linux,
    #[serde(rename = "osx-arm64")]
    OsxArm64,
    #[serde(rename = "linux-arm64")]
    LinuxArm64,
    #[serde(rename = "linux-arm32")]
    LinuxArm32,
}

impl fmt::Display for OsName {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::Osx => write!(f, "Osx"),
            Self::Windows => write!(f, "Windows"),
            Self::Linux => write!(f, "Linux"),
            Self::OsxArm64 => write!(f, "Arm64 Osx"),
            Self::LinuxArm64 => write!(f, "Arm64 Linux"),
            Self::LinuxArm32 => write!(f, "Arm32 Linux"),
        }
    }
}

#[derive(Debug, PartialEq, Eq, Serialize, Deserialize, Clone)]
pub struct Os {
    pub name: Option<OsName>,
    pub version: Option<String>,
    pub arch: Option<String>,
}

#[derive(Debug, PartialEq, Eq, Serialize, Deserialize, Clone)]
pub struct Rule {
    pub action: ActionType,
    pub features: Option<HashMap<String, Option<bool>>>,
    pub os: Option<Os>,
}

pub fn get_rules(argument: &[Value]) -> Result<Vec<Rule>> {
    let rules: anyhow::Result<Vec<Rule>> = argument
        .iter()
        .filter(|x| x["rules"][0].is_object())
        .map(|x| {
            Rule::deserialize(
                x.get("rules")
                    .context("rules doen't exists")?
                    .get(0)
                    .context("somehow rules exist but its empty")?,
            )
            .map_err(|x| anyhow!(x))
        })
        .collect();
    rules.context("Failed to collect/serialize rules")
}
