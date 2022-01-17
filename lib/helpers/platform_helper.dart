import 'package:universal_platform/universal_platform.dart';

/// Returns a new instance of [PlatformHelper].
PlatformHelper getPlatformHelper() => PlatformHelper();

/// A platform-related utilities.
class PlatformHelper {
  /// Whether the application was compiled to run on Web.
  bool get isWeb => UniversalPlatform.isWeb;
}
