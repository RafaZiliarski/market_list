import 'package:flutter/services.dart';

class Vibrator {
  static const MethodChannel _channel = MethodChannel('flutter/vibration');

  static Future<void> vibrate() async {
    try {
      await _channel.invokeMethod('vibrate');
    } catch (e) {
      print("Erro ao vibrar: $e");
    }
  }
}