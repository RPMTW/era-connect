import 'package:era_connect/api/gen/bridge_definitions.dart' as bridge;
import 'package:era_connect/api/ffi.dart';

const collectionApi = CollectionApi();

class CollectionApi {
  const CollectionApi();

  Future<void> create(
      {required String displayName,
      required bridge.VersionMetadata versionMetadata}) async {
    await api.createCollection(
        displayName: displayName, versionMetadata: versionMetadata);
  }
}
