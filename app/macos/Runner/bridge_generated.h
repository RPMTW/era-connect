#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
typedef struct _Dart_Handle* Dart_Handle;

typedef struct DartCObject DartCObject;

typedef int64_t DartPort;

typedef bool (*DartPostCObjectFnType)(DartPort port_id, void *message);

typedef struct wire_uint_8_list {
  uint8_t *ptr;
  int32_t len;
} wire_uint_8_list;

typedef struct wire_StringList {
  struct wire_uint_8_list **ptr;
  int32_t len;
} wire_StringList;

typedef struct wire_LaunchArgs {
  struct wire_StringList *jvm_args;
  struct wire_uint_8_list *main_class;
  struct wire_StringList *game_args;
} wire_LaunchArgs;

typedef struct wire_PathBuf {
  const void *ptr;
} wire_PathBuf;

typedef struct wire_JvmArgs {
  struct wire_uint_8_list *launcher_name;
  struct wire_uint_8_list *launcher_version;
  struct wire_uint_8_list *classpath;
  struct wire_uint_8_list *classpath_separator;
  struct wire_uint_8_list *primary_jar;
  struct wire_PathBuf library_directory;
  struct wire_PathBuf game_directory;
  struct wire_PathBuf native_directory;
} wire_JvmArgs;

typedef struct wire_GameArgs {
  struct wire_uint_8_list *auth_player_name;
  struct wire_uint_8_list *game_version_name;
  struct wire_PathBuf game_directory;
  struct wire_PathBuf assets_root;
  struct wire_uint_8_list *assets_index_name;
  struct wire_uint_8_list *auth_uuid;
  struct wire_uint_8_list *user_type;
  struct wire_uint_8_list *version_type;
} wire_GameArgs;

typedef struct wire_PrepareGameArgs {
  struct wire_LaunchArgs launch_args;
  struct wire_JvmArgs jvm_args;
  struct wire_GameArgs game_args;
} wire_PrepareGameArgs;

typedef struct DartCObject *WireSyncReturn;

void store_dart_post_cobject(DartPostCObjectFnType ptr);

Dart_Handle get_dart_object(uintptr_t ptr);

void drop_dart_object(uintptr_t ptr);

uintptr_t new_dart_opaque(Dart_Handle handle);

intptr_t init_frb_dart_api_dl(void *obj);

void wire_test(int64_t port_);

void wire_launch_quilt(int64_t port_, struct wire_PrepareGameArgs *quilt_prepare);

struct wire_PathBuf new_PathBuf(void);

struct wire_StringList *new_StringList_0(int32_t len);

struct wire_PrepareGameArgs *new_box_autoadd_prepare_game_args_0(void);

struct wire_uint_8_list *new_uint_8_list_0(int32_t len);

void drop_opaque_PathBuf(const void *ptr);

const void *share_opaque_PathBuf(const void *ptr);

void free_WireSyncReturn(WireSyncReturn ptr);

static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) wire_test);
    dummy_var ^= ((int64_t) (void*) wire_launch_quilt);
    dummy_var ^= ((int64_t) (void*) new_PathBuf);
    dummy_var ^= ((int64_t) (void*) new_StringList_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_prepare_game_args_0);
    dummy_var ^= ((int64_t) (void*) new_uint_8_list_0);
    dummy_var ^= ((int64_t) (void*) drop_opaque_PathBuf);
    dummy_var ^= ((int64_t) (void*) share_opaque_PathBuf);
    dummy_var ^= ((int64_t) (void*) free_WireSyncReturn);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    dummy_var ^= ((int64_t) (void*) get_dart_object);
    dummy_var ^= ((int64_t) (void*) drop_dart_object);
    dummy_var ^= ((int64_t) (void*) new_dart_opaque);
    return dummy_var;
}
