import 'package:era_connect/api/ffi.dart';
import 'package:era_connect/api/gen/bridge_definitions.dart' as bridge;
import 'config_api.dart' as config_api;

class UILayoutConfig {
  bool get completedSetup => _get<bool>(bridge.UILayoutKey.CompletedSetup);
  set completedSetup(bool value) =>
      _set(bridge.UILayoutValue.completedSetup(value));
}

T _get<T>(bridge.UILayoutKey key) {
  return config_api.get<T>(api.getUiLayoutConfig, key);
}

Future<void> _set(bridge.UILayoutValue value) {
  return api.setUiLayoutConfig(value: value);
}
