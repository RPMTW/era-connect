use anyhow::{Context, Result};
use core::fmt;
use serde_json::Value;
use std::collections::HashMap;

use serde::{Deserialize, Serialize};

#[derive(Debug, PartialEq, Eq, Serialize, Deserialize)]
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
}

impl fmt::Display for OsName {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::Osx => write!(f, "Osx"),
            Self::Windows => write!(f, "Windows"),
            Self::Linux => write!(f, "Linux"),
        }
    }
}

#[derive(Debug, PartialEq, Eq, Serialize, Deserialize)]
pub struct Os {
    pub name: Option<OsName>,
    pub version: Option<String>,
    pub arch: Option<String>,
}
#[derive(Debug, PartialEq, Eq, Serialize, Deserialize)]
pub struct Rule {
    pub action: ActionType,
    pub features: Option<HashMap<String, bool>>,
    pub os: Option<Os>,
    pub value: Option<Vec<String>>,
}

pub fn get_rules(argument: &[Value]) -> Result<Vec<Rule>> {
    let rules: Result<Vec<Rule>, _> = argument
        .iter()
        .filter(|x| x["rules"][0].is_object())
        .map(|x| Rule::deserialize(&x["rules"][0]))
        .collect();
    rules.context("Failed to collect/serialize rules")
}
