import 'ffi.dart';
import 'gen/bridge_definitions.dart' as bridge;

final ConfigAPI configAPI = ConfigAPI();

class ConfigAPI {
  // Future<bridge.UILayout> get uiLayout => api.getUiLayoutConfig();

  ConfigAPI();
}

extension UILayoutExtension on bridge.UILayout {
  Future<void> save() => api.setUiLayoutConfig(config: this);
}
