import 'dart:io';

import 'package:flutter/foundation.dart';

class AppConfig {
  static String get baseUrl {
    if (kIsWeb) {
      return 'http://localhost:8081'; // Web
    } else if (Platform.isAndroid) {
      return 'http://10.0.2.2:8081'; // Android Emulator
    } else {
      return 'http://localhost:8081'; // Default (e.g., iOS, desktop)
    }
  }
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
  };
}
