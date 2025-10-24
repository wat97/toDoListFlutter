// IO implementation used when dart:io is available (Android/iOS/desktop).
import 'dart:io' show Platform;

/// Public symbol used by `platform_check.dart` conditional import.
bool get isAndroid => Platform.isAndroid;
