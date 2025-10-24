// Conditional import: use the IO implementation when dart:io is available,
// otherwise fall back to a stub (for web).
import 'platform_check_stub.dart' if (dart.library.io) 'platform_check_io.dart';

/// Returns true when running on Android. Safe to import on all platforms.
bool get isAndroid => _isAndroid();
