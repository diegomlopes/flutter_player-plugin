import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPlayerPlugin {
  static const MethodChannel _channel =
      const MethodChannel('flutter_player_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<void> get loadFile async {
    await _channel.invokeMethod('loadFile');
  }

  static Future<void> get play async {
    await _channel.invokeMethod('play');
  }

  static Future<void> get pause async {
    await _channel.invokeMethod('pause');
  }

  static Future<void> get stop async {
    await _channel.invokeMethod('stop');
  }

  static Future<void> get playLoop async {
    await _channel.invokeMethod('play_loop');
  }
}
