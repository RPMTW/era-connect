import 'package:era_connect/api/gen/bridge_definitions.dart' as bridge;
import 'package:era_connect/api/ffi.dart';
import 'package:uuid/uuid.dart';

class AccountStorage {
  List<bridge.MinecraftAccount> get accounts =>
      _get<List<bridge.MinecraftAccount>>(bridge.AccountStorageKey.Accounts);

  Uuid? get mainAccount => _get<Uuid?>(bridge.AccountStorageKey.MainAccount);
}

T _get<T>(bridge.AccountStorageKey key) {
  return api.getAccountStorage(key: key).field0 as T;
}
