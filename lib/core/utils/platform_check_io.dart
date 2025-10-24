// IO implementation used when dart:io is available (Android/iOS/desktop).
import 'dart:io' show Platform;

bool _isAndroid() => Platform.isAndroid;
