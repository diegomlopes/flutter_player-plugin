import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPlayerPlugin {
  static const MethodChannel _channel =
      const MethodChannel('flutter_player_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
