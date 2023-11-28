use super::*;
// Section: wire functions

#[no_mangle]
pub extern "C" fn wire_setup_logger(port_: i64) {
    wire_setup_logger_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_get_ui_layout_storage(key: i32) -> support::WireSyncReturn {
    wire_get_ui_layout_storage_impl(key)
}

#[no_mangle]
pub extern "C" fn wire_set_ui_layout_storage(port_: i64, value: *mut wire_UILayoutValue) {
    wire_set_ui_layout_storage_impl(port_, value)
}

#[no_mangle]
pub extern "C" fn wire_get_account_storage(key: i32) -> support::WireSyncReturn {
    wire_get_account_storage_impl(key)
}

#[no_mangle]
pub extern "C" fn wire_get_skin_file_path(
    skin: *mut wire_MinecraftSkin,
) -> support::WireSyncReturn {
    wire_get_skin_file_path_impl(skin)
}

#[no_mangle]
pub extern "C" fn wire_remove_minecraft_account(port_: i64, uuid: *mut wire_uint_8_list) {
    wire_remove_minecraft_account_impl(port_, uuid)
}

#[no_mangle]
pub extern "C" fn wire_minecraft_login_flow(port_: i64) {
    wire_minecraft_login_flow_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_get_vanilla_versions(port_: i64) {
    wire_get_vanilla_versions_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_get_all_download_progress(port_: i64) {
    wire_get_all_download_progress_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_create_collection(
    port_: i64,
    display_name: *mut wire_uint_8_list,
    version_metadata: *mut wire_VersionMetadata,
    mod_loader: *mut wire_ModLoader,
    advanced_options: *mut wire_AdvancedOptions,
) {
    wire_create_collection_impl(
        port_,
        display_name,
        version_metadata,
        mod_loader,
        advanced_options,
    )
}

// Section: allocate functions

#[no_mangle]
pub extern "C" fn new_box_autoadd_advanced_options_0() -> *mut wire_AdvancedOptions {
    support::new_leak_box_ptr(wire_AdvancedOptions::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_minecraft_skin_0() -> *mut wire_MinecraftSkin {
    support::new_leak_box_ptr(wire_MinecraftSkin::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_mod_loader_0() -> *mut wire_ModLoader {
    support::new_leak_box_ptr(wire_ModLoader::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_ui_layout_value_0() -> *mut wire_UILayoutValue {
    support::new_leak_box_ptr(wire_UILayoutValue::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_usize_0(value: usize) -> *mut usize {
    support::new_leak_box_ptr(value)
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_version_metadata_0() -> *mut wire_VersionMetadata {
    support::new_leak_box_ptr(wire_VersionMetadata::new_with_null_ptr())
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

// Section: impl Wire2Api

impl Wire2Api<String> for *mut wire_uint_8_list {
    fn wire2api(self) -> String {
        let vec: Vec<u8> = self.wire2api();
        String::from_utf8_lossy(&vec).into_owned()
    }
}
impl Wire2Api<uuid::Uuid> for *mut wire_uint_8_list {
    fn wire2api(self) -> uuid::Uuid {
        let single: Vec<u8> = self.wire2api();
        wire2api_uuid_ref(single.as_slice())
    }
}

impl Wire2Api<AdvancedOptions> for wire_AdvancedOptions {
    fn wire2api(self) -> AdvancedOptions {
        AdvancedOptions {
            jvm_max_memory: self.jvm_max_memory.wire2api(),
        }
    }
}

impl Wire2Api<AdvancedOptions> for *mut wire_AdvancedOptions {
    fn wire2api(self) -> AdvancedOptions {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        Wire2Api::<AdvancedOptions>::wire2api(*wrap).into()
    }
}
impl Wire2Api<MinecraftSkin> for *mut wire_MinecraftSkin {
    fn wire2api(self) -> MinecraftSkin {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        Wire2Api::<MinecraftSkin>::wire2api(*wrap).into()
    }
}
impl Wire2Api<ModLoader> for *mut wire_ModLoader {
    fn wire2api(self) -> ModLoader {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        Wire2Api::<ModLoader>::wire2api(*wrap).into()
    }
}
impl Wire2Api<UILayoutValue> for *mut wire_UILayoutValue {
    fn wire2api(self) -> UILayoutValue {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        Wire2Api::<UILayoutValue>::wire2api(*wrap).into()
    }
}
impl Wire2Api<usize> for *mut usize {
    fn wire2api(self) -> usize {
        unsafe { *support::box_from_leak_ptr(self) }
    }
}
impl Wire2Api<VersionMetadata> for *mut wire_VersionMetadata {
    fn wire2api(self) -> VersionMetadata {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        Wire2Api::<VersionMetadata>::wire2api(*wrap).into()
    }
}

impl Wire2Api<MinecraftSkin> for wire_MinecraftSkin {
    fn wire2api(self) -> MinecraftSkin {
        MinecraftSkin {
            id: self.id.wire2api(),
            state: self.state.wire2api(),
            url: self.url.wire2api(),
            variant: self.variant.wire2api(),
        }
    }
}

impl Wire2Api<ModLoader> for wire_ModLoader {
    fn wire2api(self) -> ModLoader {
        ModLoader {
            mod_loader_type: self.mod_loader_type.wire2api(),
            version: self.version.wire2api(),
        }
    }
}

impl Wire2Api<UILayoutValue> for wire_UILayoutValue {
    fn wire2api(self) -> UILayoutValue {
        match self.tag {
            0 => unsafe {
                let ans = support::box_from_leak_ptr(self.kind);
                let ans = support::box_from_leak_ptr(ans.CompletedSetup);
                UILayoutValue::CompletedSetup(ans.field0.wire2api())
            },
            _ => unreachable!(),
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

impl Wire2Api<VersionMetadata> for wire_VersionMetadata {
    fn wire2api(self) -> VersionMetadata {
        VersionMetadata {
            id: self.id.wire2api(),
            version_type: self.version_type.wire2api(),
            url: self.url.wire2api(),
            uploaded_time: self.uploaded_time.wire2api(),
            release_time: self.release_time.wire2api(),
            sha1: self.sha1.wire2api(),
            compliance_level: self.compliance_level.wire2api(),
        }
    }
}

// Section: wire structs

#[repr(C)]
#[derive(Clone)]
pub struct wire_AdvancedOptions {
    jvm_max_memory: *mut usize,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_MinecraftSkin {
    id: *mut wire_uint_8_list,
    state: *mut wire_uint_8_list,
    url: *mut wire_uint_8_list,
    variant: i32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_ModLoader {
    mod_loader_type: i32,
    version: *mut wire_uint_8_list,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_uint_8_list {
    ptr: *mut u8,
    len: i32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_VersionMetadata {
    id: *mut wire_uint_8_list,
    version_type: i32,
    url: *mut wire_uint_8_list,
    uploaded_time: i64,
    release_time: i64,
    sha1: *mut wire_uint_8_list,
    compliance_level: u32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_UILayoutValue {
    tag: i32,
    kind: *mut UILayoutValueKind,
}

#[repr(C)]
pub union UILayoutValueKind {
    CompletedSetup: *mut wire_UILayoutValue_CompletedSetup,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_UILayoutValue_CompletedSetup {
    field0: bool,
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

impl NewWithNullPtr for wire_AdvancedOptions {
    fn new_with_null_ptr() -> Self {
        Self {
            jvm_max_memory: core::ptr::null_mut(),
        }
    }
}

impl Default for wire_AdvancedOptions {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}

impl NewWithNullPtr for wire_MinecraftSkin {
    fn new_with_null_ptr() -> Self {
        Self {
            id: core::ptr::null_mut(),
            state: core::ptr::null_mut(),
            url: core::ptr::null_mut(),
            variant: Default::default(),
        }
    }
}

impl Default for wire_MinecraftSkin {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}

impl NewWithNullPtr for wire_ModLoader {
    fn new_with_null_ptr() -> Self {
        Self {
            mod_loader_type: Default::default(),
            version: core::ptr::null_mut(),
        }
    }
}

impl Default for wire_ModLoader {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}

impl Default for wire_UILayoutValue {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}

impl NewWithNullPtr for wire_UILayoutValue {
    fn new_with_null_ptr() -> Self {
        Self {
            tag: -1,
            kind: core::ptr::null_mut(),
        }
    }
}

#[no_mangle]
pub extern "C" fn inflate_UILayoutValue_CompletedSetup() -> *mut UILayoutValueKind {
    support::new_leak_box_ptr(UILayoutValueKind {
        CompletedSetup: support::new_leak_box_ptr(wire_UILayoutValue_CompletedSetup {
            field0: Default::default(),
        }),
    })
}

impl NewWithNullPtr for wire_VersionMetadata {
    fn new_with_null_ptr() -> Self {
        Self {
            id: core::ptr::null_mut(),
            version_type: Default::default(),
            url: core::ptr::null_mut(),
            uploaded_time: Default::default(),
            release_time: Default::default(),
            sha1: core::ptr::null_mut(),
            compliance_level: Default::default(),
        }
    }
}

impl Default for wire_VersionMetadata {
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
