use super::*;
// Section: wire functions

#[no_mangle]
pub extern "C" fn wire_download_vanilla(port_: i64) {
    wire_download_vanilla_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_launch_game(port_: i64, pre_launch_arguments: *mut wire_PrepareGameArgs) {
    wire_launch_game_impl(port_, pre_launch_arguments)
}

#[no_mangle]
pub extern "C" fn wire_download_quilt(port_: i64, quilt_prepare: *mut wire_PrepareGameArgs) {
    wire_download_quilt_impl(port_, quilt_prepare)
}

#[no_mangle]
pub extern "C" fn wire_fetch_state(port_: i64) {
    wire_fetch_state_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_write_state(port_: i64, s: i32) {
    wire_write_state_impl(port_, s)
}

#[no_mangle]
pub extern "C" fn wire_fetch_ui_layout(port_: i64) {
    wire_fetch_ui_layout_impl(port_)
}

// Section: allocate functions

#[no_mangle]
pub extern "C" fn new_PathBuf() -> wire_PathBuf {
    wire_PathBuf::new_with_null_ptr()
}

#[no_mangle]
pub extern "C" fn new_StringList_0(len: i32) -> *mut wire_StringList {
    let wrap = wire_StringList {
        ptr: support::new_leak_vec_ptr(<*mut wire_uint_8_list>::new_with_null_ptr(), len),
        len,
    };
    support::new_leak_box_ptr(wrap)
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_prepare_game_args_0() -> *mut wire_PrepareGameArgs {
    support::new_leak_box_ptr(wire_PrepareGameArgs::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn new_uint_8_list_0(len: i32) -> *mut wire_uint_8_list {
    let ans = wire_uint_8_list {
        ptr: support::new_leak_vec_ptr(Default::default(), len),
        len,
    };
    support::new_leak_box_ptr(ans)
}

// Section: related functions

#[no_mangle]
pub extern "C" fn drop_opaque_PathBuf(ptr: *const c_void) {
    unsafe {
        Arc::<PathBuf>::decrement_strong_count(ptr as _);
    }
}

#[no_mangle]
pub extern "C" fn share_opaque_PathBuf(ptr: *const c_void) -> *const c_void {
    unsafe {
        Arc::<PathBuf>::increment_strong_count(ptr as _);
        ptr
    }
}

// Section: impl Wire2Api

impl Wire2Api<RustOpaque<PathBuf>> for wire_PathBuf {
    fn wire2api(self) -> RustOpaque<PathBuf> {
        unsafe { support::opaque_from_dart(self.ptr as _) }
    }
}
impl Wire2Api<String> for *mut wire_uint_8_list {
    fn wire2api(self) -> String {
        let vec: Vec<u8> = self.wire2api();
        String::from_utf8_lossy(&vec).into_owned()
    }
}
impl Wire2Api<Vec<String>> for *mut wire_StringList {
    fn wire2api(self) -> Vec<String> {
        let vec = unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        };
        vec.into_iter().map(Wire2Api::wire2api).collect()
    }
}
impl Wire2Api<PrepareGameArgs> for *mut wire_PrepareGameArgs {
    fn wire2api(self) -> PrepareGameArgs {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        Wire2Api::<PrepareGameArgs>::wire2api(*wrap).into()
    }
}
impl Wire2Api<GameOptions> for wire_GameOptions {
    fn wire2api(self) -> GameOptions {
        GameOptions {
            auth_player_name: self.auth_player_name.wire2api(),
            game_version_name: self.game_version_name.wire2api(),
            game_directory: self.game_directory.wire2api(),
            assets_root: self.assets_root.wire2api(),
            assets_index_name: self.assets_index_name.wire2api(),
            auth_uuid: self.auth_uuid.wire2api(),
            user_type: self.user_type.wire2api(),
            version_type: self.version_type.wire2api(),
        }
    }
}

impl Wire2Api<JvmOptions> for wire_JvmOptions {
    fn wire2api(self) -> JvmOptions {
        JvmOptions {
            launcher_name: self.launcher_name.wire2api(),
            launcher_version: self.launcher_version.wire2api(),
            classpath: self.classpath.wire2api(),
            classpath_separator: self.classpath_separator.wire2api(),
            primary_jar: self.primary_jar.wire2api(),
            library_directory: self.library_directory.wire2api(),
            game_directory: self.game_directory.wire2api(),
            native_directory: self.native_directory.wire2api(),
        }
    }
}
impl Wire2Api<LaunchArgs> for wire_LaunchArgs {
    fn wire2api(self) -> LaunchArgs {
        LaunchArgs {
            jvm_args: self.jvm_args.wire2api(),
            main_class: self.main_class.wire2api(),
            game_args: self.game_args.wire2api(),
        }
    }
}
impl Wire2Api<PrepareGameArgs> for wire_PrepareGameArgs {
    fn wire2api(self) -> PrepareGameArgs {
        PrepareGameArgs {
            launch_args: self.launch_args.wire2api(),
            jvm_args: self.jvm_args.wire2api(),
            game_args: self.game_args.wire2api(),
        }
    }
}

impl Wire2Api<Vec<u8>> for *mut wire_uint_8_list {
    fn wire2api(self) -> Vec<u8> {
        unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        }
    }
}
// Section: wire structs

#[repr(C)]
#[derive(Clone)]
pub struct wire_PathBuf {
    ptr: *const core::ffi::c_void,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_StringList {
    ptr: *mut *mut wire_uint_8_list,
    len: i32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_GameOptions {
    auth_player_name: *mut wire_uint_8_list,
    game_version_name: *mut wire_uint_8_list,
    game_directory: wire_PathBuf,
    assets_root: wire_PathBuf,
    assets_index_name: *mut wire_uint_8_list,
    auth_uuid: *mut wire_uint_8_list,
    user_type: *mut wire_uint_8_list,
    version_type: *mut wire_uint_8_list,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_JvmOptions {
    launcher_name: *mut wire_uint_8_list,
    launcher_version: *mut wire_uint_8_list,
    classpath: *mut wire_uint_8_list,
    classpath_separator: *mut wire_uint_8_list,
    primary_jar: *mut wire_uint_8_list,
    library_directory: wire_PathBuf,
    game_directory: wire_PathBuf,
    native_directory: wire_PathBuf,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_LaunchArgs {
    jvm_args: *mut wire_StringList,
    main_class: *mut wire_uint_8_list,
    game_args: *mut wire_StringList,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_PrepareGameArgs {
    launch_args: wire_LaunchArgs,
    jvm_args: wire_JvmOptions,
    game_args: wire_GameOptions,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_uint_8_list {
    ptr: *mut u8,
    len: i32,
}

// Section: impl NewWithNullPtr

pub trait NewWithNullPtr {
    fn new_with_null_ptr() -> Self;
}

impl<T> NewWithNullPtr for *mut T {
    fn new_with_null_ptr() -> Self {
        std::ptr::null_mut()
    }
}

impl NewWithNullPtr for wire_PathBuf {
    fn new_with_null_ptr() -> Self {
        Self {
            ptr: core::ptr::null(),
        }
    }
}

impl NewWithNullPtr for wire_GameOptions {
    fn new_with_null_ptr() -> Self {
        Self {
            auth_player_name: core::ptr::null_mut(),
            game_version_name: core::ptr::null_mut(),
            game_directory: wire_PathBuf::new_with_null_ptr(),
            assets_root: wire_PathBuf::new_with_null_ptr(),
            assets_index_name: core::ptr::null_mut(),
            auth_uuid: core::ptr::null_mut(),
            user_type: core::ptr::null_mut(),
            version_type: core::ptr::null_mut(),
        }
    }
}

impl Default for wire_GameOptions {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}

impl NewWithNullPtr for wire_JvmOptions {
    fn new_with_null_ptr() -> Self {
        Self {
            launcher_name: core::ptr::null_mut(),
            launcher_version: core::ptr::null_mut(),
            classpath: core::ptr::null_mut(),
            classpath_separator: core::ptr::null_mut(),
            primary_jar: core::ptr::null_mut(),
            library_directory: wire_PathBuf::new_with_null_ptr(),
            game_directory: wire_PathBuf::new_with_null_ptr(),
            native_directory: wire_PathBuf::new_with_null_ptr(),
        }
    }
}

impl Default for wire_JvmOptions {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}

impl NewWithNullPtr for wire_LaunchArgs {
    fn new_with_null_ptr() -> Self {
        Self {
            jvm_args: core::ptr::null_mut(),
            main_class: core::ptr::null_mut(),
            game_args: core::ptr::null_mut(),
        }
    }
}

impl Default for wire_LaunchArgs {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}

impl NewWithNullPtr for wire_PrepareGameArgs {
    fn new_with_null_ptr() -> Self {
        Self {
            launch_args: Default::default(),
            jvm_args: Default::default(),
            game_args: Default::default(),
        }
    }
}

impl Default for wire_PrepareGameArgs {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}

// Section: sync execution mode utility

#[no_mangle]
pub extern "C" fn free_WireSyncReturn(ptr: support::WireSyncReturn) {
    unsafe {
        let _ = support::box_from_leak_ptr(ptr);
    };
}
