import 'package:era_connect/src/rust/api/shared_resources/entry.dart';

export 'storage/lib.dart';
export 'authentication/lib.dart';
export 'meta/lib.dart';
export 'collection/collection_api.dart';

Future<void> initializeAPIs() async {
  await setupLogger();
}
