import 'package:era_connect/src/rust/api.dart';
import 'package:era_connect/src/rust/api/storage/ui_layout.dart';

class UILayoutStorage {
  const UILayoutStorage();

  bool get completedSetup => _get<bool>(UILayoutKey.completedSetup);
  set completedSetup(bool value) => _set(UILayoutValue.completedSetup(value));
}

T _get<T>(UILayoutKey key) {
  return getUiLayoutStorage(key: key).field0 as T;
}

Future<void> _set(UILayoutValue value) {
  return setUiLayoutStorage(value: value);
}
