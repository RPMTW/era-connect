import 'package:era_connect/api/storage/account_storage.dart';
import 'package:meta/meta.dart';

import 'ui_layout.dart';

StorageApi _storageApi = const StorageApi();

StorageApi get storageApi => _storageApi;
@visibleForTesting
set storageApi(StorageApi value) {
  _storageApi = value;
}

class StorageApi {
  final UILayoutStorage uiLayout;
  final AccountStorage accountStorage;

  const StorageApi()
      : uiLayout = const UILayoutStorage(),
        accountStorage = const AccountStorage();
}
