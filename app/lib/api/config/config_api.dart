import 'package:era_connect/api/gen/bridge_definitions.dart' as bridge;

import 'ui_layout.dart';

final ConfigApi configApi = ConfigApi();

class ConfigApi {
  final UILayoutConfig uiLayout = UILayoutConfig();

  ConfigApi();
}

T get<T>(
    bridge.Value Function({required bridge.Key key}) function, bridge.Key key) {
  return function(key: key).field0 as T;
}
