import 'package:era_connect/src/rust/api.dart';
import 'package:era_connect/src/rust/api/vanilla/version.dart';

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
