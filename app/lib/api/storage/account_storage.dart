import 'package:era_connect/api/gen/bridge_definitions.dart' as bridge;
import 'package:era_connect/api/ffi.dart';
import 'package:uuid/uuid.dart';

class AccountStorage {
  const AccountStorage();

  List<bridge.MinecraftAccount> get accounts =>
      _get<List<bridge.MinecraftAccount>>(bridge.AccountStorageKey.Accounts);

  UuidValue? get mainAccount =>
      _get<UuidValue?>(bridge.AccountStorageKey.MainAccount);

  Future<void> removeAccount(UuidValue uuid) {
    return api.removeMinecraftAccount(uuid: uuid);
  }
}

T _get<T>(bridge.AccountStorageKey key) {
  return api.getAccountStorage(key: key).field0 as T;
}
