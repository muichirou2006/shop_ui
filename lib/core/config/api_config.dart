import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

class ApiConfig {
  ApiConfig._();

  /// Override at run time, e.g. for a real phone on your Wi-Fi:
  /// flutter run --dart-define=API_BASE_URL=http://192.168.1.20:3000/api/v1
  static const _override = String.fromEnvironment('API_BASE_URL');

  static String get baseUrl {
    if (_override.isNotEmpty) return _override;
    // The Android emulator reaches your computer through 10.0.2.2.
    if (!kIsWeb && Platform.isAndroid) return 'http://10.0.2.2:3000/api/v1';
    // iOS simulator shares the host's network.
    return 'http://localhost:3000/api/v1';
  }
}
