import 'package:era_connect/api/gen/bridge_definitions.dart' as bridge;
import 'package:meta/meta.dart';

import 'ui_layout.dart';

final ConfigApi configApi = ConfigApi();

class ConfigApi {
  UILayoutConfig _uiLayout = UILayoutConfig();

  UILayoutConfig get uiLayout => _uiLayout;
  @visibleForTesting
  set uiLayout(UILayoutConfig value) {
    _uiLayout = value;
  }

  ConfigApi();
}

T get<T>(
    bridge.Value Function({required bridge.Key key}) function, bridge.Key key) {
  return function(key: key).field0 as T;
}
