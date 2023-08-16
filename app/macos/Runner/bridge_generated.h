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

typedef struct wire_AccountToken {
  struct wire_uint_8_list *token;
  int64_t expires_at;
} wire_AccountToken;

typedef struct wire_MinecraftSkin {
  struct wire_uint_8_list *id;
  struct wire_uint_8_list *state;
  struct wire_uint_8_list *url;
  int32_t variant;
} wire_MinecraftSkin;

typedef struct wire_list_minecraft_skin {
  struct wire_MinecraftSkin *ptr;
  int32_t len;
} wire_list_minecraft_skin;

typedef struct wire_MinecraftCape {
  struct wire_uint_8_list *id;
  struct wire_uint_8_list *state;
  struct wire_uint_8_list *url;
  struct wire_uint_8_list *alias;
} wire_MinecraftCape;

typedef struct wire_list_minecraft_cape {
  struct wire_MinecraftCape *ptr;
  int32_t len;
} wire_list_minecraft_cape;

typedef struct wire_MinecraftAccount {
  struct wire_uint_8_list *username;
  struct wire_uint_8_list *uuid;
  struct wire_AccountToken access_token;
  struct wire_AccountToken refresh_token;
  struct wire_list_minecraft_skin *skins;
  struct wire_list_minecraft_cape *capes;
} wire_MinecraftAccount;

typedef struct wire_list_minecraft_account {
  struct wire_MinecraftAccount *ptr;
  int32_t len;
} wire_list_minecraft_account;

typedef struct wire_AccountStorageValue_Accounts {
  struct wire_list_minecraft_account *field0;
} wire_AccountStorageValue_Accounts;

typedef struct wire_AccountStorageValue_MainAccount {
  struct wire_uint_8_list *field0;
} wire_AccountStorageValue_MainAccount;

typedef union AccountStorageValueKind {
  struct wire_AccountStorageValue_Accounts *Accounts;
  struct wire_AccountStorageValue_MainAccount *MainAccount;
} AccountStorageValueKind;

typedef struct wire_AccountStorageValue {
  int32_t tag;
  union AccountStorageValueKind *kind;
} wire_AccountStorageValue;

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

void wire_set_account_storage(int64_t port_, struct wire_AccountStorageValue *value);

void wire_minecraft_login_flow(int64_t port_);

struct wire_AccountStorageValue *new_box_autoadd_account_storage_value_0(void);

struct wire_UILayoutValue *new_box_autoadd_ui_layout_value_0(void);

struct wire_list_minecraft_account *new_list_minecraft_account_0(int32_t len);

struct wire_list_minecraft_cape *new_list_minecraft_cape_0(int32_t len);

struct wire_list_minecraft_skin *new_list_minecraft_skin_0(int32_t len);

struct wire_uint_8_list *new_uint_8_list_0(int32_t len);

union AccountStorageValueKind *inflate_AccountStorageValue_Accounts(void);

union AccountStorageValueKind *inflate_AccountStorageValue_MainAccount(void);

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
    dummy_var ^= ((int64_t) (void*) wire_set_account_storage);
    dummy_var ^= ((int64_t) (void*) wire_minecraft_login_flow);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_account_storage_value_0);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_ui_layout_value_0);
    dummy_var ^= ((int64_t) (void*) new_list_minecraft_account_0);
    dummy_var ^= ((int64_t) (void*) new_list_minecraft_cape_0);
    dummy_var ^= ((int64_t) (void*) new_list_minecraft_skin_0);
    dummy_var ^= ((int64_t) (void*) new_uint_8_list_0);
    dummy_var ^= ((int64_t) (void*) inflate_AccountStorageValue_Accounts);
    dummy_var ^= ((int64_t) (void*) inflate_AccountStorageValue_MainAccount);
    dummy_var ^= ((int64_t) (void*) inflate_UILayoutValue_CompletedSetup);
    dummy_var ^= ((int64_t) (void*) free_WireSyncReturn);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    dummy_var ^= ((int64_t) (void*) get_dart_object);
    dummy_var ^= ((int64_t) (void*) drop_dart_object);
    dummy_var ^= ((int64_t) (void*) new_dart_opaque);
    return dummy_var;
}
