import 'package:era_connect/api/lib.dart';
import 'package:era_connect/src/rust/api/shared_resources/entry.dart' as api;

const metaApi = MetaApi();

class MetaApi {
  const MetaApi();

  Future<List<VersionMetadata>> getVanillaVersions() =>
      api.getVanillaVersions();
}
