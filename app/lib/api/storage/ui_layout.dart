import 'package:era_connect/src/rust/api/backend_exclusive/storage/ui_layout.dart';
import 'package:era_connect/src/rust/api/shared_resources/entry.dart';

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
