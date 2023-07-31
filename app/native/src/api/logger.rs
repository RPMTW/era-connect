use chrono::Utc;
use flutter_rust_bridge::StreamSink;
use log::{Level, Log};

pub enum LogLevel {
    Error,
    Warn,
    Info,
    Debug,
    Trace,
}

pub struct LogEntry {
    pub level: LogLevel,
    pub message: String,
    pub time_millis: i64,
}
pub struct EraConnectLogger {
    pub stream: StreamSink<LogEntry>,
}

impl LogLevel {
    fn from(level: Level) -> Self {
        match level {
            Level::Error => Self::Error,
            Level::Warn => Self::Warn,
            Level::Info => Self::Info,
            Level::Debug => Self::Debug,
            Level::Trace => Self::Trace,
        }
    }
}

impl Log for EraConnectLogger {
    fn enabled(&self, metadata: &log::Metadata) -> bool {
        if cfg!(debug_assertions) {
            true
        } else {
            metadata.level() <= Level::Info
        }
    }

    fn log(&self, record: &log::Record) {
        let entry = LogEntry {
            level: LogLevel::from(record.level()),
            message: record.args().to_string(),
            time_millis: Utc::now().timestamp_millis(),
        };
        self.stream.add(entry);
    }

    fn flush(&self) {}
}
