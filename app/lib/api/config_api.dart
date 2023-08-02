import 'ffi.dart';
import 'gen/bridge_definitions.dart' as bridge;

final ConfigAPI configAPI = ConfigAPI();

class ConfigAPI {
  final UILayoutConfig uiLayout = UILayoutConfig();

  ConfigAPI();
}

class UILayoutConfig {
  bool get completedSetup =>
      _get<bool>(api.getUiLayoutConfig, bridge.Key.CompletedSetup);
}

T _get<T>(
    bridge.Value Function({required bridge.Key key}) function, bridge.Key key) {
  return function(key: key).field0 as T;
}
