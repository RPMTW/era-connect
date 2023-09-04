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

typedef struct wire_uint_8_list {
  uint8_t *ptr;
  int32_t len;
} wire_uint_8_list;

typedef struct wire_MinecraftSkin {
  struct wire_uint_8_list *id;
  struct wire_uint_8_list *state;
  struct wire_uint_8_list *url;
  int32_t variant;
} wire_MinecraftSkin;

typedef struct wire_VersionMetadata {
  struct wire_uint_8_list *id;
  int32_t version_type;
  struct wire_uint_8_list *url;
  int64_t uploaded_time;
  int64_t release_time;
  struct wire_uint_8_list *sha1;
  uint32_t compliance_level;
} wire_VersionMetadata;

typedef struct wire_ModLoader {
  int32_t mod_loader_type;
  struct wire_uint_8_list *version;
} wire_ModLoader;

typedef struct wire_AdvancedOptions {
  uintptr_t *jvm_max_memory;
} wire_AdvancedOptions;

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

WireSyncReturn wire_get_ui_layout_storage(int32_t key);

void wire_set_ui_layout_storage(int64_t port_, struct wire_UILayoutValue *value);

WireSyncReturn wire_get_account_storage(int32_t key);

WireSyncReturn wire_get_skin_file_path(struct wire_MinecraftSkin *skin);

void wire_remove_minecraft_account(int64_t port_, struct wire_uint_8_list *uuid);

void wire_minecraft_login_flow(int64_t port_);

void wire_get_vanilla_versions(int64_t port_);

void wire_create_collection(int64_t port_,
                            struct wire_uint_8_list *display_name,
                            struct wire_VersionMetadata *version_metadata,
                            struct wire_ModLoader *mod_loader,
                            struct wire_AdvancedOptions *advanced_options);

struct wire_AdvancedOptions *new_box_autoadd_advanced_options_0(void);

struct wire_MinecraftSkin *new_box_autoadd_minecraft_skin_0(void);

struct wire_ModLoader *new_box_autoadd_mod_loader_0(void);

struct wire_UILayoutValue *new_box_autoadd_ui_layout_value_0(void);

uintptr_t *new_box_autoadd_usize_0(uintptr_t value);

struct wire_VersionMetadata *new_box_autoadd_version_metadata_0(void);

struct wire_uint_8_list *new_uint_8_list_0(int32_t len);

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
    dummy_var ^= ((int64_t) (void*) wire_get_ui_layout_storage);
    dummy_var ^= ((int64_t) (void*) wire_set_ui_layout_storage);
    dummy_var ^= ((int64_t) (void*) wire_get_account_storage);
    dummy_var ^= ((int64_t) (void*) wire_get_skin_file_path);
    dummy_var ^= ((int64_t) (void*) wire_remove_minecraft_account);
    dummy_var ^= ((int64_t) (void*) wire_minecraft_login_flow);
    dummy_var ^= ((int64_t) (void*) wire_get_vanilla_versions);
    dummy_var ^= ((int64_t) (void*) wire_create_collection);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_advanced_options_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_minecraft_skin_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_mod_loader_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_ui_layout_value_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_usize_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_version_metadata_0);
    dummy_var ^= ((int64_t) (void*) new_uint_8_list_0);
    dummy_var ^= ((int64_t) (void*) inflate_UILayoutValue_CompletedSetup);
    dummy_var ^= ((int64_t) (void*) free_WireSyncReturn);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    dummy_var ^= ((int64_t) (void*) get_dart_object);
    dummy_var ^= ((int64_t) (void*) drop_dart_object);
    dummy_var ^= ((int64_t) (void*) new_dart_opaque);
    return dummy_var;
}
