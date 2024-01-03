// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.11.

// Section: imports

use super::*;
use crate::api::shared_resources::authentication::account::*;
use crate::api::shared_resources::collection::*;
use flutter_rust_bridge::for_generated::byteorder::{NativeEndian, ReadBytesExt, WriteBytesExt};
use flutter_rust_bridge::for_generated::transform_result_dco;
use flutter_rust_bridge::{Handler, IntoIntoDart};

// Section: dart2rust

impl CstDecode<anyhow::Error> for *mut wire_cst_list_prim_u_8 {
    fn cst_decode(self) -> anyhow::Error {
        unimplemented!()
    }
}
impl CstDecode<flutter_rust_bridge::RustOpaque<std::sync::RwLock<PathBuf>>>
    for *const std::ffi::c_void
{
    fn cst_decode(self) -> flutter_rust_bridge::RustOpaque<std::sync::RwLock<PathBuf>> {
        unsafe { flutter_rust_bridge::for_generated::cst_decode_rust_opaque(self) }
    }
}
impl
    CstDecode<
        flutter_rust_bridge::RustOpaque<
            std::sync::RwLock<
                Vec<crate::api::backend_exclusive::storage::storage_loader::StorageLoader>,
            >,
        >,
    > for *const std::ffi::c_void
{
    fn cst_decode(
        self,
    ) -> flutter_rust_bridge::RustOpaque<
        std::sync::RwLock<
            Vec<crate::api::backend_exclusive::storage::storage_loader::StorageLoader>,
        >,
    > {
        unsafe { flutter_rust_bridge::for_generated::cst_decode_rust_opaque(self) }
    }
}
impl
    CstDecode<
        flutter_rust_bridge::RustOpaque<
            std::sync::RwLock<crate::api::shared_resources::collection::Collection>,
        >,
    > for *const std::ffi::c_void
{
    fn cst_decode(
        self,
    ) -> flutter_rust_bridge::RustOpaque<
        std::sync::RwLock<crate::api::shared_resources::collection::Collection>,
    > {
        unsafe { flutter_rust_bridge::for_generated::cst_decode_rust_opaque(self) }
    }
}
impl
    CstDecode<
        flutter_rust_bridge::RustOpaque<
            std::sync::RwLock<crate::api::shared_resources::collection::TemporaryTuple>,
        >,
    > for *const std::ffi::c_void
{
    fn cst_decode(
        self,
    ) -> flutter_rust_bridge::RustOpaque<
        std::sync::RwLock<crate::api::shared_resources::collection::TemporaryTuple>,
    > {
        unsafe { flutter_rust_bridge::for_generated::cst_decode_rust_opaque(self) }
    }
}
impl CstDecode<String> for *mut wire_cst_list_prim_u_8 {
    fn cst_decode(self) -> String {
        let vec: Vec<u8> = self.cst_decode();
        String::from_utf8(vec).unwrap()
    }
}
impl CstDecode<uuid::Uuid> for *mut wire_cst_list_prim_u_8 {
    fn cst_decode(self) -> uuid::Uuid {
        let single: Vec<u8> = self.cst_decode();
        flutter_rust_bridge::for_generated::decode_uuid(single)
    }
}
impl CstDecode<crate::api::backend_exclusive::storage::account_storage::AccountStorageValue>
    for wire_cst_account_storage_value
{
    fn cst_decode(
        self,
    ) -> crate::api::backend_exclusive::storage::account_storage::AccountStorageValue {
        match self.tag {
            0 => {
                let ans = unsafe { self.kind.Accounts };
                crate::api::backend_exclusive::storage::account_storage::AccountStorageValue::Accounts( ans.field0.cst_decode())
            }
            1 => {
                let ans = unsafe { self.kind.MainAccount };
                crate::api::backend_exclusive::storage::account_storage::AccountStorageValue::MainAccount( ans.field0.cst_decode())
            }
            _ => unreachable!(),
        }
    }
}
impl CstDecode<crate::api::shared_resources::authentication::account::AccountToken>
    for wire_cst_account_token
{
    fn cst_decode(self) -> crate::api::shared_resources::authentication::account::AccountToken {
        crate::api::shared_resources::authentication::account::AccountToken {
            token: self.token.cst_decode(),
            expires_at: self.expires_at.cst_decode(),
        }
    }
}
impl CstDecode<crate::api::shared_resources::collection::AdvancedOptions>
    for wire_cst_advanced_options
{
    fn cst_decode(self) -> crate::api::shared_resources::collection::AdvancedOptions {
        crate::api::shared_resources::collection::AdvancedOptions {
            jvm_max_memory: self.jvm_max_memory.cst_decode(),
        }
    }
}
impl CstDecode<crate::api::shared_resources::collection::AdvancedOptions>
    for *mut wire_cst_advanced_options
{
    fn cst_decode(self) -> crate::api::shared_resources::collection::AdvancedOptions {
        let wrap = unsafe { flutter_rust_bridge::for_generated::box_from_leak_ptr(self) };
        CstDecode::<crate::api::shared_resources::collection::AdvancedOptions>::cst_decode(*wrap)
            .into()
    }
}
impl CstDecode<crate::api::shared_resources::authentication::msa_flow::LoginFlowDeviceCode>
    for *mut wire_cst_login_flow_device_code
{
    fn cst_decode(
        self,
    ) -> crate::api::shared_resources::authentication::msa_flow::LoginFlowDeviceCode {
        let wrap = unsafe { flutter_rust_bridge::for_generated::box_from_leak_ptr(self) };
        CstDecode::<crate::api::shared_resources::authentication::msa_flow::LoginFlowDeviceCode>::cst_decode(*wrap).into()
    }
}
impl CstDecode<crate::api::shared_resources::authentication::msa_flow::LoginFlowErrors>
    for *mut wire_cst_login_flow_errors
{
    fn cst_decode(self) -> crate::api::shared_resources::authentication::msa_flow::LoginFlowErrors {
        let wrap = unsafe { flutter_rust_bridge::for_generated::box_from_leak_ptr(self) };
        CstDecode::<crate::api::shared_resources::authentication::msa_flow::LoginFlowErrors>::cst_decode(*wrap).into()
    }
}
impl CstDecode<crate::api::shared_resources::authentication::account::MinecraftAccount>
    for *mut wire_cst_minecraft_account
{
    fn cst_decode(self) -> crate::api::shared_resources::authentication::account::MinecraftAccount {
        let wrap = unsafe { flutter_rust_bridge::for_generated::box_from_leak_ptr(self) };
        CstDecode::<crate::api::shared_resources::authentication::account::MinecraftAccount>::cst_decode(*wrap).into()
    }
}
impl CstDecode<crate::api::shared_resources::authentication::account::MinecraftSkin>
    for *mut wire_cst_minecraft_skin
{
    fn cst_decode(self) -> crate::api::shared_resources::authentication::account::MinecraftSkin {
        let wrap = unsafe { flutter_rust_bridge::for_generated::box_from_leak_ptr(self) };
        CstDecode::<crate::api::shared_resources::authentication::account::MinecraftSkin>::cst_decode(*wrap).into()
    }
}
impl CstDecode<crate::api::shared_resources::collection::ModLoader> for *mut wire_cst_mod_loader {
    fn cst_decode(self) -> crate::api::shared_resources::collection::ModLoader {
        let wrap = unsafe { flutter_rust_bridge::for_generated::box_from_leak_ptr(self) };
        CstDecode::<crate::api::shared_resources::collection::ModLoader>::cst_decode(*wrap).into()
    }
}
impl CstDecode<crate::api::backend_exclusive::storage::ui_layout::UILayoutValue>
    for *mut wire_cst_ui_layout_value
{
    fn cst_decode(self) -> crate::api::backend_exclusive::storage::ui_layout::UILayoutValue {
        let wrap = unsafe { flutter_rust_bridge::for_generated::box_from_leak_ptr(self) };
        CstDecode::<crate::api::backend_exclusive::storage::ui_layout::UILayoutValue>::cst_decode(
            *wrap,
        )
        .into()
    }
}
impl CstDecode<usize> for *mut usize {
    fn cst_decode(self) -> usize {
        unsafe { *flutter_rust_bridge::for_generated::box_from_leak_ptr(self) }
    }
}
impl CstDecode<crate::api::backend_exclusive::vanilla::version::VersionMetadata>
    for *mut wire_cst_version_metadata
{
    fn cst_decode(self) -> crate::api::backend_exclusive::vanilla::version::VersionMetadata {
        let wrap = unsafe { flutter_rust_bridge::for_generated::box_from_leak_ptr(self) };
        CstDecode::<crate::api::backend_exclusive::vanilla::version::VersionMetadata>::cst_decode(
            *wrap,
        )
        .into()
    }
}
impl CstDecode<crate::api::shared_resources::collection::CollectionId> for wire_cst_collection_id {
    fn cst_decode(self) -> crate::api::shared_resources::collection::CollectionId {
        crate::api::shared_resources::collection::CollectionId(self.field0.cst_decode())
    }
}
impl CstDecode<Vec<crate::api::shared_resources::authentication::account::MinecraftAccount>>
    for *mut wire_cst_list_minecraft_account
{
    fn cst_decode(
        self,
    ) -> Vec<crate::api::shared_resources::authentication::account::MinecraftAccount> {
        let vec = unsafe {
            let wrap = flutter_rust_bridge::for_generated::box_from_leak_ptr(self);
            flutter_rust_bridge::for_generated::vec_from_leak_ptr(wrap.ptr, wrap.len)
        };
        vec.into_iter().map(CstDecode::cst_decode).collect()
    }
}
impl CstDecode<Vec<crate::api::shared_resources::authentication::account::MinecraftCape>>
    for *mut wire_cst_list_minecraft_cape
{
    fn cst_decode(
        self,
    ) -> Vec<crate::api::shared_resources::authentication::account::MinecraftCape> {
        let vec = unsafe {
            let wrap = flutter_rust_bridge::for_generated::box_from_leak_ptr(self);
            flutter_rust_bridge::for_generated::vec_from_leak_ptr(wrap.ptr, wrap.len)
        };
        vec.into_iter().map(CstDecode::cst_decode).collect()
    }
}
impl CstDecode<Vec<crate::api::shared_resources::authentication::account::MinecraftSkin>>
    for *mut wire_cst_list_minecraft_skin
{
    fn cst_decode(
        self,
    ) -> Vec<crate::api::shared_resources::authentication::account::MinecraftSkin> {
        let vec = unsafe {
            let wrap = flutter_rust_bridge::for_generated::box_from_leak_ptr(self);
            flutter_rust_bridge::for_generated::vec_from_leak_ptr(wrap.ptr, wrap.len)
        };
        vec.into_iter().map(CstDecode::cst_decode).collect()
    }
}
impl CstDecode<Vec<u8>> for *mut wire_cst_list_prim_u_8 {
    fn cst_decode(self) -> Vec<u8> {
        unsafe {
            let wrap = flutter_rust_bridge::for_generated::box_from_leak_ptr(self);
            flutter_rust_bridge::for_generated::vec_from_leak_ptr(wrap.ptr, wrap.len)
        }
    }
}
impl CstDecode<Vec<crate::api::backend_exclusive::vanilla::version::VersionMetadata>>
    for *mut wire_cst_list_version_metadata
{
    fn cst_decode(self) -> Vec<crate::api::backend_exclusive::vanilla::version::VersionMetadata> {
        let vec = unsafe {
            let wrap = flutter_rust_bridge::for_generated::box_from_leak_ptr(self);
            flutter_rust_bridge::for_generated::vec_from_leak_ptr(wrap.ptr, wrap.len)
        };
        vec.into_iter().map(CstDecode::cst_decode).collect()
    }
}
impl CstDecode<crate::api::shared_resources::authentication::msa_flow::LoginFlowDeviceCode>
    for wire_cst_login_flow_device_code
{
    fn cst_decode(
        self,
    ) -> crate::api::shared_resources::authentication::msa_flow::LoginFlowDeviceCode {
        crate::api::shared_resources::authentication::msa_flow::LoginFlowDeviceCode {
            verification_uri: self.verification_uri.cst_decode(),
            user_code: self.user_code.cst_decode(),
        }
    }
}
impl CstDecode<crate::api::shared_resources::authentication::msa_flow::LoginFlowErrors>
    for wire_cst_login_flow_errors
{
    fn cst_decode(self) -> crate::api::shared_resources::authentication::msa_flow::LoginFlowErrors {
        match self.tag {
                    0 => {
                        let ans = unsafe { self.kind.XstsError };
                        crate::api::shared_resources::authentication::msa_flow::LoginFlowErrors::XstsError( ans.field0.cst_decode())
                    }
1 => crate::api::shared_resources::authentication::msa_flow::LoginFlowErrors::GameNotOwned,
2 => {
                        let ans = unsafe { self.kind.UnknownError };
                        crate::api::shared_resources::authentication::msa_flow::LoginFlowErrors::UnknownError( ans.field0.cst_decode())
                    }
                    _ => unreachable!(),
                }
    }
}
impl CstDecode<crate::api::shared_resources::authentication::msa_flow::LoginFlowEvent>
    for wire_cst_login_flow_event
{
    fn cst_decode(self) -> crate::api::shared_resources::authentication::msa_flow::LoginFlowEvent {
        match self.tag {
            0 => {
                let ans = unsafe { self.kind.Stage };
                crate::api::shared_resources::authentication::msa_flow::LoginFlowEvent::Stage(
                    ans.field0.cst_decode(),
                )
            }
            1 => {
                let ans = unsafe { self.kind.DeviceCode };
                crate::api::shared_resources::authentication::msa_flow::LoginFlowEvent::DeviceCode(
                    ans.field0.cst_decode(),
                )
            }
            2 => {
                let ans = unsafe { self.kind.Error };
                crate::api::shared_resources::authentication::msa_flow::LoginFlowEvent::Error(
                    ans.field0.cst_decode(),
                )
            }
            3 => {
                let ans = unsafe { self.kind.Success };
                crate::api::shared_resources::authentication::msa_flow::LoginFlowEvent::Success(
                    ans.field0.cst_decode(),
                )
            }
            _ => unreachable!(),
        }
    }
}
impl CstDecode<crate::api::shared_resources::authentication::account::MinecraftAccount>
    for wire_cst_minecraft_account
{
    fn cst_decode(self) -> crate::api::shared_resources::authentication::account::MinecraftAccount {
        crate::api::shared_resources::authentication::account::MinecraftAccount {
            username: self.username.cst_decode(),
            uuid: self.uuid.cst_decode(),
            access_token: self.access_token.cst_decode(),
            refresh_token: self.refresh_token.cst_decode(),
            skins: self.skins.cst_decode(),
            capes: self.capes.cst_decode(),
        }
    }
}
impl CstDecode<crate::api::shared_resources::authentication::account::MinecraftCape>
    for wire_cst_minecraft_cape
{
    fn cst_decode(self) -> crate::api::shared_resources::authentication::account::MinecraftCape {
        crate::api::shared_resources::authentication::account::MinecraftCape {
            id: self.id.cst_decode(),
            state: self.state.cst_decode(),
            url: self.url.cst_decode(),
            alias: self.alias.cst_decode(),
        }
    }
}
impl CstDecode<crate::api::shared_resources::authentication::account::MinecraftSkin>
    for wire_cst_minecraft_skin
{
    fn cst_decode(self) -> crate::api::shared_resources::authentication::account::MinecraftSkin {
        crate::api::shared_resources::authentication::account::MinecraftSkin {
            id: self.id.cst_decode(),
            state: self.state.cst_decode(),
            url: self.url.cst_decode(),
            variant: self.variant.cst_decode(),
        }
    }
}
impl CstDecode<crate::api::shared_resources::collection::ModLoader> for wire_cst_mod_loader {
    fn cst_decode(self) -> crate::api::shared_resources::collection::ModLoader {
        crate::api::shared_resources::collection::ModLoader {
            mod_loader_type: self.mod_loader_type.cst_decode(),
            version: self.version.cst_decode(),
        }
    }
}
impl CstDecode<crate::api::backend_exclusive::storage::ui_layout::UILayoutValue>
    for wire_cst_ui_layout_value
{
    fn cst_decode(self) -> crate::api::backend_exclusive::storage::ui_layout::UILayoutValue {
        match self.tag {
            0 => {
                let ans = unsafe { self.kind.CompletedSetup };
                crate::api::backend_exclusive::storage::ui_layout::UILayoutValue::CompletedSetup(
                    ans.field0.cst_decode(),
                )
            }
            _ => unreachable!(),
        }
    }
}
impl CstDecode<crate::api::backend_exclusive::vanilla::version::VersionMetadata>
    for wire_cst_version_metadata
{
    fn cst_decode(self) -> crate::api::backend_exclusive::vanilla::version::VersionMetadata {
        crate::api::backend_exclusive::vanilla::version::VersionMetadata {
            id: self.id.cst_decode(),
            version_type: self.version_type.cst_decode(),
            url: self.url.cst_decode(),
            uploaded_time: self.uploaded_time.cst_decode(),
            release_time: self.release_time.cst_decode(),
            sha1: self.sha1.cst_decode(),
            compliance_level: self.compliance_level.cst_decode(),
        }
    }
}
pub trait NewWithNullPtr {
    fn new_with_null_ptr() -> Self;
}

impl<T> NewWithNullPtr for *mut T {
    fn new_with_null_ptr() -> Self {
        std::ptr::null_mut()
    }
}
impl NewWithNullPtr for wire_cst_account_storage_value {
    fn new_with_null_ptr() -> Self {
        Self {
            tag: -1,
            kind: AccountStorageValueKind { nil__: () },
        }
    }
}
impl Default for wire_cst_account_storage_value {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}
impl NewWithNullPtr for wire_cst_account_token {
    fn new_with_null_ptr() -> Self {
        Self {
            token: core::ptr::null_mut(),
            expires_at: Default::default(),
        }
    }
}
impl Default for wire_cst_account_token {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}
impl NewWithNullPtr for wire_cst_advanced_options {
    fn new_with_null_ptr() -> Self {
        Self {
            jvm_max_memory: core::ptr::null_mut(),
        }
    }
}
impl Default for wire_cst_advanced_options {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}
impl NewWithNullPtr for wire_cst_collection_id {
    fn new_with_null_ptr() -> Self {
        Self {
            field0: core::ptr::null_mut(),
        }
    }
}
impl Default for wire_cst_collection_id {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}
impl NewWithNullPtr for wire_cst_login_flow_device_code {
    fn new_with_null_ptr() -> Self {
        Self {
            verification_uri: core::ptr::null_mut(),
            user_code: core::ptr::null_mut(),
        }
    }
}
impl Default for wire_cst_login_flow_device_code {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}
impl NewWithNullPtr for wire_cst_login_flow_errors {
    fn new_with_null_ptr() -> Self {
        Self {
            tag: -1,
            kind: LoginFlowErrorsKind { nil__: () },
        }
    }
}
impl Default for wire_cst_login_flow_errors {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}
impl NewWithNullPtr for wire_cst_login_flow_event {
    fn new_with_null_ptr() -> Self {
        Self {
            tag: -1,
            kind: LoginFlowEventKind { nil__: () },
        }
    }
}
impl Default for wire_cst_login_flow_event {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}
impl NewWithNullPtr for wire_cst_minecraft_account {
    fn new_with_null_ptr() -> Self {
        Self {
            username: core::ptr::null_mut(),
            uuid: core::ptr::null_mut(),
            access_token: Default::default(),
            refresh_token: Default::default(),
            skins: core::ptr::null_mut(),
            capes: core::ptr::null_mut(),
        }
    }
}
impl Default for wire_cst_minecraft_account {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}
impl NewWithNullPtr for wire_cst_minecraft_cape {
    fn new_with_null_ptr() -> Self {
        Self {
            id: core::ptr::null_mut(),
            state: core::ptr::null_mut(),
            url: core::ptr::null_mut(),
            alias: core::ptr::null_mut(),
        }
    }
}
impl Default for wire_cst_minecraft_cape {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}
impl NewWithNullPtr for wire_cst_minecraft_skin {
    fn new_with_null_ptr() -> Self {
        Self {
            id: core::ptr::null_mut(),
            state: core::ptr::null_mut(),
            url: core::ptr::null_mut(),
            variant: Default::default(),
        }
    }
}
impl Default for wire_cst_minecraft_skin {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}
impl NewWithNullPtr for wire_cst_mod_loader {
    fn new_with_null_ptr() -> Self {
        Self {
            mod_loader_type: Default::default(),
            version: core::ptr::null_mut(),
        }
    }
}
impl Default for wire_cst_mod_loader {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}
impl NewWithNullPtr for wire_cst_ui_layout_value {
    fn new_with_null_ptr() -> Self {
        Self {
            tag: -1,
            kind: UILayoutValueKind { nil__: () },
        }
    }
}
impl Default for wire_cst_ui_layout_value {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}
impl NewWithNullPtr for wire_cst_version_metadata {
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
impl Default for wire_cst_version_metadata {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_dart_fn_deliver_output(
    call_id: i32,
    ptr_: *mut u8,
    rust_vec_len_: i32,
    data_len_: i32,
) {
    let message = unsafe {
        flutter_rust_bridge::for_generated::Dart2RustMessageSse::from_wire(
            ptr_,
            rust_vec_len_,
            data_len_,
        )
    };
    FLUTTER_RUST_BRIDGE_HANDLER.dart_fn_handle_output(call_id, message)
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_wire_MinecraftSkin_get_head_file_path(
    port_: i64,
    that: *mut wire_cst_minecraft_skin,
) {
    wire_MinecraftSkin_get_head_file_path_impl(port_, that)
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_wire_Collection_create(
    port_: i64,
    display_name: *mut wire_cst_list_prim_u_8,
    version_metadata: *mut wire_cst_version_metadata,
    mod_loader: *mut wire_cst_mod_loader,
    advanced_options: *mut wire_cst_advanced_options,
) {
    wire_Collection_create_impl(
        port_,
        display_name,
        version_metadata,
        mod_loader,
        advanced_options,
    )
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_wire_Collection_game_directory(
    port_: i64,
    that: *const std::ffi::c_void,
) {
    wire_Collection_game_directory_impl(port_, that)
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_wire_Collection_get_base_path(port_: i64) {
    wire_Collection_get_base_path_impl(port_)
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_wire_Collection_get_collection_id(
    port_: i64,
    that: *const std::ffi::c_void,
) {
    wire_Collection_get_collection_id_impl(port_, that)
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_wire_Collection_scan(port_: i64) {
    wire_Collection_scan_impl(port_)
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_wire_create_collection(
    port_: i64,
    display_name: *mut wire_cst_list_prim_u_8,
    version_metadata: *mut wire_cst_version_metadata,
    mod_loader: *mut wire_cst_mod_loader,
    advanced_options: *mut wire_cst_advanced_options,
) {
    wire_create_collection_impl(
        port_,
        display_name,
        version_metadata,
        mod_loader,
        advanced_options,
    )
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_wire_get_account_storage(
    key: i32,
) -> flutter_rust_bridge::for_generated::WireSyncRust2DartDco {
    wire_get_account_storage_impl(key)
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_wire_get_skin_file_path(
    skin: *mut wire_cst_minecraft_skin,
) -> flutter_rust_bridge::for_generated::WireSyncRust2DartDco {
    wire_get_skin_file_path_impl(skin)
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_wire_get_ui_layout_storage(
    key: i32,
) -> flutter_rust_bridge::for_generated::WireSyncRust2DartDco {
    wire_get_ui_layout_storage_impl(key)
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_wire_get_vanilla_versions(port_: i64) {
    wire_get_vanilla_versions_impl(port_)
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_wire_minecraft_login_flow(port_: i64) {
    wire_minecraft_login_flow_impl(port_)
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_wire_remove_minecraft_account(
    port_: i64,
    uuid: *mut wire_cst_list_prim_u_8,
) {
    wire_remove_minecraft_account_impl(port_, uuid)
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_wire_set_ui_layout_storage(
    port_: i64,
    value: *mut wire_cst_ui_layout_value,
) {
    wire_set_ui_layout_storage_impl(port_, value)
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_wire_setup_logger(port_: i64) {
    wire_setup_logger_impl(port_)
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_rust_arc_increment_strong_count_RustOpaque_stdsyncRwLockPathBuf(
    ptr: *const std::ffi::c_void,
) {
    unsafe {
        flutter_rust_bridge::for_generated::rust_arc_increment_strong_count::<
            std::sync::RwLock<PathBuf>,
        >(ptr);
    }
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_rust_arc_decrement_strong_count_RustOpaque_stdsyncRwLockPathBuf(
    ptr: *const std::ffi::c_void,
) {
    unsafe {
        flutter_rust_bridge::for_generated::rust_arc_decrement_strong_count::<
            std::sync::RwLock<PathBuf>,
        >(ptr);
    }
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_rust_arc_increment_strong_count_RustOpaque_stdsyncRwLockVeccrateapibackend_exclusivestoragestorage_loaderStorageLoader(
    ptr: *const std::ffi::c_void,
) {
    unsafe {
        flutter_rust_bridge::for_generated::rust_arc_increment_strong_count::<
            std::sync::RwLock<
                Vec<crate::api::backend_exclusive::storage::storage_loader::StorageLoader>,
            >,
        >(ptr);
    }
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_rust_arc_decrement_strong_count_RustOpaque_stdsyncRwLockVeccrateapibackend_exclusivestoragestorage_loaderStorageLoader(
    ptr: *const std::ffi::c_void,
) {
    unsafe {
        flutter_rust_bridge::for_generated::rust_arc_decrement_strong_count::<
            std::sync::RwLock<
                Vec<crate::api::backend_exclusive::storage::storage_loader::StorageLoader>,
            >,
        >(ptr);
    }
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_rust_arc_increment_strong_count_RustOpaque_stdsyncRwLockcrateapishared_resourcescollectionCollection(
    ptr: *const std::ffi::c_void,
) {
    unsafe {
        flutter_rust_bridge::for_generated::rust_arc_increment_strong_count::<
            std::sync::RwLock<crate::api::shared_resources::collection::Collection>,
        >(ptr);
    }
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_rust_arc_decrement_strong_count_RustOpaque_stdsyncRwLockcrateapishared_resourcescollectionCollection(
    ptr: *const std::ffi::c_void,
) {
    unsafe {
        flutter_rust_bridge::for_generated::rust_arc_decrement_strong_count::<
            std::sync::RwLock<crate::api::shared_resources::collection::Collection>,
        >(ptr);
    }
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_rust_arc_increment_strong_count_RustOpaque_stdsyncRwLockcrateapishared_resourcescollectionTemporaryTuple(
    ptr: *const std::ffi::c_void,
) {
    unsafe {
        flutter_rust_bridge::for_generated::rust_arc_increment_strong_count::<
            std::sync::RwLock<crate::api::shared_resources::collection::TemporaryTuple>,
        >(ptr);
    }
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_rust_arc_decrement_strong_count_RustOpaque_stdsyncRwLockcrateapishared_resourcescollectionTemporaryTuple(
    ptr: *const std::ffi::c_void,
) {
    unsafe {
        flutter_rust_bridge::for_generated::rust_arc_decrement_strong_count::<
            std::sync::RwLock<crate::api::shared_resources::collection::TemporaryTuple>,
        >(ptr);
    }
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_cst_new_box_autoadd_advanced_options(
) -> *mut wire_cst_advanced_options {
    flutter_rust_bridge::for_generated::new_leak_box_ptr(
        wire_cst_advanced_options::new_with_null_ptr(),
    )
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_cst_new_box_autoadd_login_flow_device_code(
) -> *mut wire_cst_login_flow_device_code {
    flutter_rust_bridge::for_generated::new_leak_box_ptr(
        wire_cst_login_flow_device_code::new_with_null_ptr(),
    )
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_cst_new_box_autoadd_login_flow_errors(
) -> *mut wire_cst_login_flow_errors {
    flutter_rust_bridge::for_generated::new_leak_box_ptr(
        wire_cst_login_flow_errors::new_with_null_ptr(),
    )
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_cst_new_box_autoadd_minecraft_account(
) -> *mut wire_cst_minecraft_account {
    flutter_rust_bridge::for_generated::new_leak_box_ptr(
        wire_cst_minecraft_account::new_with_null_ptr(),
    )
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_cst_new_box_autoadd_minecraft_skin(
) -> *mut wire_cst_minecraft_skin {
    flutter_rust_bridge::for_generated::new_leak_box_ptr(
        wire_cst_minecraft_skin::new_with_null_ptr(),
    )
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_cst_new_box_autoadd_mod_loader() -> *mut wire_cst_mod_loader {
    flutter_rust_bridge::for_generated::new_leak_box_ptr(wire_cst_mod_loader::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_cst_new_box_autoadd_ui_layout_value(
) -> *mut wire_cst_ui_layout_value {
    flutter_rust_bridge::for_generated::new_leak_box_ptr(
        wire_cst_ui_layout_value::new_with_null_ptr(),
    )
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_cst_new_box_autoadd_usize(value: usize) -> *mut usize {
    flutter_rust_bridge::for_generated::new_leak_box_ptr(value)
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_cst_new_box_autoadd_version_metadata(
) -> *mut wire_cst_version_metadata {
    flutter_rust_bridge::for_generated::new_leak_box_ptr(
        wire_cst_version_metadata::new_with_null_ptr(),
    )
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_cst_new_list_minecraft_account(
    len: i32,
) -> *mut wire_cst_list_minecraft_account {
    let wrap = wire_cst_list_minecraft_account {
        ptr: flutter_rust_bridge::for_generated::new_leak_vec_ptr(
            <wire_cst_minecraft_account>::new_with_null_ptr(),
            len,
        ),
        len,
    };
    flutter_rust_bridge::for_generated::new_leak_box_ptr(wrap)
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_cst_new_list_minecraft_cape(
    len: i32,
) -> *mut wire_cst_list_minecraft_cape {
    let wrap = wire_cst_list_minecraft_cape {
        ptr: flutter_rust_bridge::for_generated::new_leak_vec_ptr(
            <wire_cst_minecraft_cape>::new_with_null_ptr(),
            len,
        ),
        len,
    };
    flutter_rust_bridge::for_generated::new_leak_box_ptr(wrap)
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_cst_new_list_minecraft_skin(
    len: i32,
) -> *mut wire_cst_list_minecraft_skin {
    let wrap = wire_cst_list_minecraft_skin {
        ptr: flutter_rust_bridge::for_generated::new_leak_vec_ptr(
            <wire_cst_minecraft_skin>::new_with_null_ptr(),
            len,
        ),
        len,
    };
    flutter_rust_bridge::for_generated::new_leak_box_ptr(wrap)
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_cst_new_list_prim_u_8(
    len: i32,
) -> *mut wire_cst_list_prim_u_8 {
    let ans = wire_cst_list_prim_u_8 {
        ptr: flutter_rust_bridge::for_generated::new_leak_vec_ptr(Default::default(), len),
        len,
    };
    flutter_rust_bridge::for_generated::new_leak_box_ptr(ans)
}

#[no_mangle]
pub extern "C" fn frbgen_era_connect_cst_new_list_version_metadata(
    len: i32,
) -> *mut wire_cst_list_version_metadata {
    let wrap = wire_cst_list_version_metadata {
        ptr: flutter_rust_bridge::for_generated::new_leak_vec_ptr(
            <wire_cst_version_metadata>::new_with_null_ptr(),
            len,
        ),
        len,
    };
    flutter_rust_bridge::for_generated::new_leak_box_ptr(wrap)
}

#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_account_storage_value {
    tag: i32,
    kind: AccountStorageValueKind,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub union AccountStorageValueKind {
    Accounts: wire_cst_AccountStorageValue_Accounts,
    MainAccount: wire_cst_AccountStorageValue_MainAccount,
    nil__: (),
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_AccountStorageValue_Accounts {
    field0: *mut wire_cst_list_minecraft_account,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_AccountStorageValue_MainAccount {
    field0: *mut wire_cst_list_prim_u_8,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_account_token {
    token: *mut wire_cst_list_prim_u_8,
    expires_at: i64,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_advanced_options {
    jvm_max_memory: *mut usize,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_collection_id {
    field0: *mut wire_cst_list_prim_u_8,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_list_minecraft_account {
    ptr: *mut wire_cst_minecraft_account,
    len: i32,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_list_minecraft_cape {
    ptr: *mut wire_cst_minecraft_cape,
    len: i32,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_list_minecraft_skin {
    ptr: *mut wire_cst_minecraft_skin,
    len: i32,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_list_prim_u_8 {
    ptr: *mut u8,
    len: i32,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_list_version_metadata {
    ptr: *mut wire_cst_version_metadata,
    len: i32,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_login_flow_device_code {
    verification_uri: *mut wire_cst_list_prim_u_8,
    user_code: *mut wire_cst_list_prim_u_8,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_login_flow_errors {
    tag: i32,
    kind: LoginFlowErrorsKind,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub union LoginFlowErrorsKind {
    XstsError: wire_cst_LoginFlowErrors_XstsError,
    UnknownError: wire_cst_LoginFlowErrors_UnknownError,
    nil__: (),
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_LoginFlowErrors_XstsError {
    field0: i32,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_LoginFlowErrors_UnknownError {
    field0: *mut wire_cst_list_prim_u_8,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_login_flow_event {
    tag: i32,
    kind: LoginFlowEventKind,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub union LoginFlowEventKind {
    Stage: wire_cst_LoginFlowEvent_Stage,
    DeviceCode: wire_cst_LoginFlowEvent_DeviceCode,
    Error: wire_cst_LoginFlowEvent_Error,
    Success: wire_cst_LoginFlowEvent_Success,
    nil__: (),
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_LoginFlowEvent_Stage {
    field0: i32,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_LoginFlowEvent_DeviceCode {
    field0: *mut wire_cst_login_flow_device_code,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_LoginFlowEvent_Error {
    field0: *mut wire_cst_login_flow_errors,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_LoginFlowEvent_Success {
    field0: *mut wire_cst_minecraft_account,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_minecraft_account {
    username: *mut wire_cst_list_prim_u_8,
    uuid: *mut wire_cst_list_prim_u_8,
    access_token: wire_cst_account_token,
    refresh_token: wire_cst_account_token,
    skins: *mut wire_cst_list_minecraft_skin,
    capes: *mut wire_cst_list_minecraft_cape,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_minecraft_cape {
    id: *mut wire_cst_list_prim_u_8,
    state: *mut wire_cst_list_prim_u_8,
    url: *mut wire_cst_list_prim_u_8,
    alias: *mut wire_cst_list_prim_u_8,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_minecraft_skin {
    id: *mut wire_cst_list_prim_u_8,
    state: *mut wire_cst_list_prim_u_8,
    url: *mut wire_cst_list_prim_u_8,
    variant: i32,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_mod_loader {
    mod_loader_type: i32,
    version: *mut wire_cst_list_prim_u_8,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_ui_layout_value {
    tag: i32,
    kind: UILayoutValueKind,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub union UILayoutValueKind {
    CompletedSetup: wire_cst_UILayoutValue_CompletedSetup,
    nil__: (),
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_UILayoutValue_CompletedSetup {
    field0: bool,
}
#[repr(C)]
#[derive(Clone, Copy)]
pub struct wire_cst_version_metadata {
    id: *mut wire_cst_list_prim_u_8,
    version_type: i32,
    url: *mut wire_cst_list_prim_u_8,
    uploaded_time: i64,
    release_time: i64,
    sha1: *mut wire_cst_list_prim_u_8,
    compliance_level: u32,
}
