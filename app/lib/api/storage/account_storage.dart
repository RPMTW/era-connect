import 'package:era_connect/api/lib.dart';
import 'package:era_connect/src/rust/api/shared_resources/authentication/account.dart';
import 'package:era_connect/src/rust/api/shared_resources/entry.dart';
import 'package:era_connect/src/rust/api/backend_exclusive/storage/account_storage.dart';
import 'package:uuid/uuid.dart';

class AccountStorage {
  const AccountStorage();

  List<MinecraftAccount> get accounts =>
      _get<List<MinecraftAccount>>(AccountStorageKey.accounts);

  UuidValue? get mainAccount => _get<UuidValue?>(AccountStorageKey.mainAccount);

  Future<void> removeAccount(UuidValue uuid) {
    return removeMinecraftAccount(uuid: uuid);
  }
}

T _get<T>(AccountStorageKey key) {
  return getAccountStorage(key: key).field0 as T;
}
