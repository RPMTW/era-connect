#![allow(
    non_camel_case_types,
    unused,
    clippy::redundant_closure,
    clippy::useless_conversion,
    clippy::unit_arg,
    clippy::double_parens,
    non_snake_case,
    clippy::too_many_arguments
)]
// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.78.0.

use crate::api::*;
use core::panic::UnwindSafe;
use flutter_rust_bridge::*;
use std::ffi::c_void;
use std::sync::Arc;

// Section: imports

// Section: wire functions

fn wire_test_impl(port_: MessagePort, channels: impl Wire2Api<StateChannel> + UnwindSafe) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "test",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_channels = channels.wire2api();
            move |task_callback| test(api_channels)
        },
    )
}
fn wire_download_vanilla_impl(
    port_: MessagePort,
    channels: impl Wire2Api<StateChannel> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "download_vanilla",
            port: Some(port_),
            mode: FfiCallMode::Stream,
        },
        move || {
            let api_channels = channels.wire2api();
            move |task_callback| download_vanilla(task_callback.stream_sink(), api_channels)
        },
    )
}
fn wire_launch_game_impl(
    port_: MessagePort,
    pre_launch_arguments: impl Wire2Api<PrepareGameArgs> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "launch_game",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_pre_launch_arguments = pre_launch_arguments.wire2api();
            move |task_callback| launch_game(api_pre_launch_arguments)
        },
    )
}
fn wire_download_quilt_impl(
    port_: MessagePort,
    channels: impl Wire2Api<StateChannel> + UnwindSafe,
    quilt_prepare: impl Wire2Api<PrepareGameArgs> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "download_quilt",
            port: Some(port_),
            mode: FfiCallMode::Stream,
        },
        move || {
            let api_channels = channels.wire2api();
            let api_quilt_prepare = quilt_prepare.wire2api();
            move |task_callback| {
                download_quilt(task_callback.stream_sink(), api_channels, api_quilt_prepare)
            }
        },
    )
}
fn wire_fetch_impl(port_: MessagePort) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "fetch",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || move |task_callback| Ok(fetch()),
    )
}
fn wire_state_write_impl(
    port_: MessagePort,
    s: impl Wire2Api<State> + UnwindSafe,
    channel: impl Wire2Api<StateChannel> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "state_write",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_s = s.wire2api();
            let api_channel = channel.wire2api();
            move |task_callback| Ok(state_write(api_s, api_channel))
        },
    )
}
// Section: wrapper structs

// Section: static checks

// Section: allocate functions

// Section: related functions

// Section: impl Wire2Api

pub trait Wire2Api<T> {
    fn wire2api(self) -> T;
}

impl<T, S> Wire2Api<Option<T>> for *mut S
where
    *mut S: Wire2Api<T>,
{
    fn wire2api(self) -> Option<T> {
        (!self.is_null()).then(|| self.wire2api())
    }
}

impl Wire2Api<i32> for i32 {
    fn wire2api(self) -> i32 {
        self
    }
}

impl Wire2Api<State> for i32 {
    fn wire2api(self) -> State {
        match self {
            0 => State::Downloading,
            1 => State::Paused,
            2 => State::ForceCancel,
            _ => unreachable!("Invalid variant for State: {}", self),
        }
    }
}

impl Wire2Api<u8> for u8 {
    fn wire2api(self) -> u8 {
        self
    }
}

// Section: impl IntoDart

impl support::IntoDart for GameOptions {
    fn into_dart(self) -> support::DartAbi {
        vec![
            self.auth_player_name.into_dart(),
            self.game_version_name.into_dart(),
            self.game_directory.into_dart(),
            self.assets_root.into_dart(),
            self.assets_index_name.into_dart(),
            self.auth_uuid.into_dart(),
            self.user_type.into_dart(),
            self.version_type.into_dart(),
        ]
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for GameOptions {}

impl support::IntoDart for JvmOptions {
    fn into_dart(self) -> support::DartAbi {
        vec![
            self.launcher_name.into_dart(),
            self.launcher_version.into_dart(),
            self.classpath.into_dart(),
            self.classpath_separator.into_dart(),
            self.primary_jar.into_dart(),
            self.library_directory.into_dart(),
            self.game_directory.into_dart(),
            self.native_directory.into_dart(),
        ]
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for JvmOptions {}

impl support::IntoDart for LaunchArgs {
    fn into_dart(self) -> support::DartAbi {
        vec![
            self.jvm_args.into_dart(),
            self.main_class.into_dart(),
            self.game_args.into_dart(),
        ]
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for LaunchArgs {}

impl support::IntoDart for PrepareGameArgs {
    fn into_dart(self) -> support::DartAbi {
        vec![
            self.launch_args.into_dart(),
            self.jvm_args.into_dart(),
            self.game_args.into_dart(),
        ]
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for PrepareGameArgs {}

impl support::IntoDart for Progress {
    fn into_dart(self) -> support::DartAbi {
        vec![
            self.speed.into_dart(),
            self.percentages.into_dart(),
            self.current_size.into_dart(),
            self.total_size.into_dart(),
        ]
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for Progress {}

impl support::IntoDart for ReturnType {
    fn into_dart(self) -> support::DartAbi {
        vec![
            self.progress.into_dart(),
            self.prepare_name_args.into_dart(),
        ]
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for ReturnType {}

impl support::IntoDart for StateChannel {
    fn into_dart(self) -> support::DartAbi {
        vec![self.sender.into_dart(), self.receiver.into_dart()].into_dart()
    }
}
impl support::IntoDartExceptPrimitive for StateChannel {}

// Section: executor

support::lazy_static! {
    pub static ref FLUTTER_RUST_BRIDGE_HANDLER: support::DefaultHandler = Default::default();
}

#[cfg(not(target_family = "wasm"))]
#[path = "bridge_generated.io.rs"]
mod io;
#[cfg(not(target_family = "wasm"))]
pub use io::*;
