use super::*;
// Section: wire functions

#[no_mangle]
pub extern "C" fn wire_setup_logger(port_: i64) {
    wire_setup_logger_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_launch_vanilla(port_: i64) {
    wire_launch_vanilla_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_launch_forge(port_: i64) {
    wire_launch_forge_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_launch_quilt(port_: i64) {
    wire_launch_quilt_impl(port_)
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
pub extern "C" fn wire_set_account_storage(port_: i64, value: *mut wire_AccountStorageValue) {
    wire_set_account_storage_impl(port_, value)
}

#[no_mangle]
pub extern "C" fn wire_minecraft_login_flow(port_: i64) {
    wire_minecraft_login_flow_impl(port_)
}

// Section: allocate functions

#[no_mangle]
pub extern "C" fn new_box_autoadd_account_storage_value_0() -> *mut wire_AccountStorageValue {
    support::new_leak_box_ptr(wire_AccountStorageValue::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_ui_layout_value_0() -> *mut wire_UILayoutValue {
    support::new_leak_box_ptr(wire_UILayoutValue::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn new_list_minecraft_account_0(len: i32) -> *mut wire_list_minecraft_account {
    let wrap = wire_list_minecraft_account {
        ptr: support::new_leak_vec_ptr(<wire_MinecraftAccount>::new_with_null_ptr(), len),
        len,
    };
    support::new_leak_box_ptr(wrap)
}

#[no_mangle]
pub extern "C" fn new_list_minecraft_cape_0(len: i32) -> *mut wire_list_minecraft_cape {
    let wrap = wire_list_minecraft_cape {
        ptr: support::new_leak_vec_ptr(<wire_MinecraftCape>::new_with_null_ptr(), len),
        len,
    };
    support::new_leak_box_ptr(wrap)
}

#[no_mangle]
pub extern "C" fn new_list_minecraft_skin_0(len: i32) -> *mut wire_list_minecraft_skin {
    let wrap = wire_list_minecraft_skin {
        ptr: support::new_leak_vec_ptr(<wire_MinecraftSkin>::new_with_null_ptr(), len),
        len,
    };
    support::new_leak_box_ptr(wrap)
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

impl Wire2Api<AccountStorageValue> for wire_AccountStorageValue {
    fn wire2api(self) -> AccountStorageValue {
        match self.tag {
            0 => unsafe {
                let ans = support::box_from_leak_ptr(self.kind);
                let ans = support::box_from_leak_ptr(ans.Accounts);
                AccountStorageValue::Accounts(ans.field0.wire2api())
            },
            1 => unsafe {
                let ans = support::box_from_leak_ptr(self.kind);
                let ans = support::box_from_leak_ptr(ans.MainAccount);
                AccountStorageValue::MainAccount(ans.field0.wire2api())
            },
            _ => unreachable!(),
        }
    }
}
impl Wire2Api<AccountToken> for wire_AccountToken {
    fn wire2api(self) -> AccountToken {
        AccountToken {
            token: self.token.wire2api(),
            expires_at: self.expires_at.wire2api(),
        }
    }
}

impl Wire2Api<AccountStorageValue> for *mut wire_AccountStorageValue {
    fn wire2api(self) -> AccountStorageValue {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        Wire2Api::<AccountStorageValue>::wire2api(*wrap).into()
    }
}
impl Wire2Api<UILayoutValue> for *mut wire_UILayoutValue {
    fn wire2api(self) -> UILayoutValue {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        Wire2Api::<UILayoutValue>::wire2api(*wrap).into()
    }
}

impl Wire2Api<Vec<MinecraftAccount>> for *mut wire_list_minecraft_account {
    fn wire2api(self) -> Vec<MinecraftAccount> {
        let vec = unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        };
        vec.into_iter().map(Wire2Api::wire2api).collect()
    }
}
impl Wire2Api<Vec<MinecraftCape>> for *mut wire_list_minecraft_cape {
    fn wire2api(self) -> Vec<MinecraftCape> {
        let vec = unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        };
        vec.into_iter().map(Wire2Api::wire2api).collect()
    }
}
impl Wire2Api<Vec<MinecraftSkin>> for *mut wire_list_minecraft_skin {
    fn wire2api(self) -> Vec<MinecraftSkin> {
        let vec = unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        };
        vec.into_iter().map(Wire2Api::wire2api).collect()
    }
}
impl Wire2Api<MinecraftAccount> for wire_MinecraftAccount {
    fn wire2api(self) -> MinecraftAccount {
        MinecraftAccount {
            username: self.username.wire2api(),
            uuid: self.uuid.wire2api(),
            access_token: self.access_token.wire2api(),
            refresh_token: self.refresh_token.wire2api(),
            skins: self.skins.wire2api(),
            capes: self.capes.wire2api(),
        }
    }
}
impl Wire2Api<MinecraftCape> for wire_MinecraftCape {
    fn wire2api(self) -> MinecraftCape {
        MinecraftCape {
            id: self.id.wire2api(),
            state: self.state.wire2api(),
            url: self.url.wire2api(),
            alias: self.alias.wire2api(),
        }
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
// Section: wire structs

#[repr(C)]
#[derive(Clone)]
pub struct wire_AccountToken {
    token: *mut wire_uint_8_list,
    expires_at: i64,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_list_minecraft_account {
    ptr: *mut wire_MinecraftAccount,
    len: i32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_list_minecraft_cape {
    ptr: *mut wire_MinecraftCape,
    len: i32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_list_minecraft_skin {
    ptr: *mut wire_MinecraftSkin,
    len: i32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_MinecraftAccount {
    username: *mut wire_uint_8_list,
    uuid: *mut wire_uint_8_list,
    access_token: wire_AccountToken,
    refresh_token: wire_AccountToken,
    skins: *mut wire_list_minecraft_skin,
    capes: *mut wire_list_minecraft_cape,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_MinecraftCape {
    id: *mut wire_uint_8_list,
    state: *mut wire_uint_8_list,
    url: *mut wire_uint_8_list,
    alias: *mut wire_uint_8_list,
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
pub struct wire_uint_8_list {
    ptr: *mut u8,
    len: i32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_AccountStorageValue {
    tag: i32,
    kind: *mut AccountStorageValueKind,
}

#[repr(C)]
pub union AccountStorageValueKind {
    Accounts: *mut wire_AccountStorageValue_Accounts,
    MainAccount: *mut wire_AccountStorageValue_MainAccount,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_AccountStorageValue_Accounts {
    field0: *mut wire_list_minecraft_account,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_AccountStorageValue_MainAccount {
    field0: *mut wire_uint_8_list,
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

impl Default for wire_AccountStorageValue {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}

impl NewWithNullPtr for wire_AccountStorageValue {
    fn new_with_null_ptr() -> Self {
        Self {
            tag: -1,
            kind: core::ptr::null_mut(),
        }
    }
}

#[no_mangle]
pub extern "C" fn inflate_AccountStorageValue_Accounts() -> *mut AccountStorageValueKind {
    support::new_leak_box_ptr(AccountStorageValueKind {
        Accounts: support::new_leak_box_ptr(wire_AccountStorageValue_Accounts {
            field0: core::ptr::null_mut(),
        }),
    })
}

#[no_mangle]
pub extern "C" fn inflate_AccountStorageValue_MainAccount() -> *mut AccountStorageValueKind {
    support::new_leak_box_ptr(AccountStorageValueKind {
        MainAccount: support::new_leak_box_ptr(wire_AccountStorageValue_MainAccount {
            field0: core::ptr::null_mut(),
        }),
    })
}

impl NewWithNullPtr for wire_AccountToken {
    fn new_with_null_ptr() -> Self {
        Self {
            token: core::ptr::null_mut(),
            expires_at: Default::default(),
        }
    }
}

impl Default for wire_AccountToken {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}

impl NewWithNullPtr for wire_MinecraftAccount {
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

impl Default for wire_MinecraftAccount {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}

impl NewWithNullPtr for wire_MinecraftCape {
    fn new_with_null_ptr() -> Self {
        Self {
            id: core::ptr::null_mut(),
            state: core::ptr::null_mut(),
            url: core::ptr::null_mut(),
            alias: core::ptr::null_mut(),
        }
    }
}

impl Default for wire_MinecraftCape {
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

// Section: sync execution mode utility

#[no_mangle]
pub extern "C" fn free_WireSyncReturn(ptr: support::WireSyncReturn) {
    unsafe {
        let _ = support::box_from_leak_ptr(ptr);
    };
}
