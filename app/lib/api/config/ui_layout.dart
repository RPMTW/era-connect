import 'package:era_connect/api/ffi.dart';
import 'package:era_connect/api/gen/bridge_definitions.dart' as bridge;
import 'config_api.dart' as config_api;

class UILayoutConfig {
  bool get completedSetup => _get<bool>(bridge.Key.completed_setup);
  set completedSetup(bool value) => _set(bridge.Value.completedSetup(value));
}

T _get<T>(bridge.Key key) {
  return config_api.get<T>(api.getUiLayoutConfig, key);
}

Future<void> _set(bridge.Value value) {
  return api.setUiLayoutConfig(value: value);
}
