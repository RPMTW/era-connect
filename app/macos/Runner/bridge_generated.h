#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
typedef struct _Dart_Handle* Dart_Handle;

typedef struct DartCObject DartCObject;

typedef int64_t DartPort;

typedef bool (*DartPostCObjectFnType)(DartPort port_id, void *message);

typedef struct DartCObject *WireSyncReturn;

typedef struct wire_UILayoutValue_CompletedSetup {
  bool field0;
} wire_UILayoutValue_CompletedSetup;

typedef union UILayoutValueKind {
  struct wire_UILayoutValue_CompletedSetup *CompletedSetup;
} UILayoutValueKind;

typedef struct wire_UILayoutValue {
  int32_t tag;
  union UILayoutValueKind *kind;
} wire_UILayoutValue;

void store_dart_post_cobject(DartPostCObjectFnType ptr);

Dart_Handle get_dart_object(uintptr_t ptr);

void drop_dart_object(uintptr_t ptr);

uintptr_t new_dart_opaque(Dart_Handle handle);

intptr_t init_frb_dart_api_dl(void *obj);

void wire_setup_logger(int64_t port_);

void wire_launch_vanilla(int64_t port_);

void wire_launch_forge(int64_t port_);

void wire_launch_quilt(int64_t port_);

void wire_fetch_state(int64_t port_);

void wire_write_state(int64_t port_, int32_t s);

WireSyncReturn wire_get_ui_layout_config(int32_t key);

void wire_set_ui_layout_config(int64_t port_, struct wire_UILayoutValue *value);

struct wire_UILayoutValue *new_box_autoadd_ui_layout_value_0(void);

union UILayoutValueKind *inflate_UILayoutValue_CompletedSetup(void);

void free_WireSyncReturn(WireSyncReturn ptr);

static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) wire_setup_logger);
    dummy_var ^= ((int64_t) (void*) wire_launch_vanilla);
    dummy_var ^= ((int64_t) (void*) wire_launch_forge);
    dummy_var ^= ((int64_t) (void*) wire_launch_quilt);
    dummy_var ^= ((int64_t) (void*) wire_fetch_state);
    dummy_var ^= ((int64_t) (void*) wire_write_state);
    dummy_var ^= ((int64_t) (void*) wire_get_ui_layout_config);
    dummy_var ^= ((int64_t) (void*) wire_set_ui_layout_config);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_ui_layout_value_0);
    dummy_var ^= ((int64_t) (void*) inflate_UILayoutValue_CompletedSetup);
    dummy_var ^= ((int64_t) (void*) free_WireSyncReturn);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    dummy_var ^= ((int64_t) (void*) get_dart_object);
    dummy_var ^= ((int64_t) (void*) drop_dart_object);
    dummy_var ^= ((int64_t) (void*) new_dart_opaque);
    return dummy_var;
}
