import 'package:era_connect/src/rust/api/backend_exclusive/vanilla/version.dart';
import 'package:era_connect/src/rust/api/shared_resources/entry.dart';

const collectionApi = CollectionApi();

class CollectionApi {
  const CollectionApi();

  Future<void> create(
      {required String displayName,
      required VersionMetadata versionMetadata}) async {
    await createCollection(
        displayName: displayName, versionMetadata: versionMetadata);
  }
}
