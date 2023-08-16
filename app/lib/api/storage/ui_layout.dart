import 'package:era_connect/api/gen/bridge_definitions.dart' as bridge;
import 'package:era_connect/api/ffi.dart';

class UILayoutStorage {
  bool get completedSetup => _get<bool>(bridge.UILayoutKey.CompletedSetup);
  set completedSetup(bool value) =>
      _set(bridge.UILayoutValue.completedSetup(value));
}

T _get<T>(bridge.UILayoutKey key) {
  return api.getUiLayoutStorage(key: key).field0 as T;
}

Future<void> _set(bridge.UILayoutValue value) {
  return api.setUiLayoutStorage(value: value);
}
