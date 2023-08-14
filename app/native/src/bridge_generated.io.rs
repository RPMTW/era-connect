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
pub extern "C" fn wire_get_ui_layout_config(key: i32) -> support::WireSyncReturn {
    wire_get_ui_layout_config_impl(key)
}

#[no_mangle]
pub extern "C" fn wire_set_ui_layout_config(port_: i64, value: *mut wire_Value) {
    wire_set_ui_layout_config_impl(port_, value)
}

#[no_mangle]
pub extern "C" fn wire_minecraft_login_flow(port_: i64) {
    wire_minecraft_login_flow_impl(port_)
}

// Section: allocate functions

#[no_mangle]
pub extern "C" fn new_box_autoadd_value_0() -> *mut wire_Value {
    support::new_leak_box_ptr(wire_Value::new_with_null_ptr())
}

// Section: related functions

// Section: impl Wire2Api

impl Wire2Api<Value> for *mut wire_Value {
    fn wire2api(self) -> Value {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        Wire2Api::<Value>::wire2api(*wrap).into()
    }
}

impl Wire2Api<Value> for wire_Value {
    fn wire2api(self) -> Value {
        match self.tag {
            0 => unsafe {
                let ans = support::box_from_leak_ptr(self.kind);
                let ans = support::box_from_leak_ptr(ans.CompletedSetup);
                Value::CompletedSetup(ans.field0.wire2api())
            },
            _ => unreachable!(),
        }
    }
}
// Section: wire structs

#[repr(C)]
#[derive(Clone)]
pub struct wire_Value {
    tag: i32,
    kind: *mut ValueKind,
}

#[repr(C)]
pub union ValueKind {
    CompletedSetup: *mut wire_Value_CompletedSetup,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_Value_CompletedSetup {
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

impl Default for wire_Value {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}

impl NewWithNullPtr for wire_Value {
    fn new_with_null_ptr() -> Self {
        Self {
            tag: -1,
            kind: core::ptr::null_mut(),
        }
    }
}

#[no_mangle]
pub extern "C" fn inflate_Value_CompletedSetup() -> *mut ValueKind {
    support::new_leak_box_ptr(ValueKind {
        CompletedSetup: support::new_leak_box_ptr(wire_Value_CompletedSetup {
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
