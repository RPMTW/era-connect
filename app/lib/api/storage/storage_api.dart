import 'package:era_connect/api/storage/account_storage.dart';
import 'package:meta/meta.dart';

import 'ui_layout.dart';

final StorageApi storageApi = StorageApi();

class StorageApi {
  UILayoutStorage _uiLayout = UILayoutStorage();

  UILayoutStorage get uiLayout => _uiLayout;
  @visibleForTesting
  set uiLayout(UILayoutStorage value) {
    _uiLayout = value;
  }

  final accountStorage = AccountStorage();

  StorageApi();
}
