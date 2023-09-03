import 'package:era_connect/api/gen/bridge_definitions.dart' as bridge;
import 'package:era_connect/api/ffi.dart';

const metaApi = MetaApi();

class MetaApi {
  const MetaApi();

  Future<List<bridge.VersionMetadata>> getVanillaVersions() =>
      api.getVanillaVersions();
}
