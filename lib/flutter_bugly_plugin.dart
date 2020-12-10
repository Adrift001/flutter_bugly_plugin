
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterBuglyPlugin {
  static const MethodChannel _channel =
      const MethodChannel('flutter_bugly_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
