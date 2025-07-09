import 'package:flutter/cupertino.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';

class DeviceSecurity {
  static Future<bool?> isDeviceCompromised({
    JailbreakRootDetection? detection,
  }) async {
    final detector = detection ?? JailbreakRootDetection.instance;
    try {
      final jailBroken = await detector.isJailBroken;
      final isReal = await detector.isRealDevice;
      final isNotTrusted = await detector.isNotTrust;
      debugPrint(
        'jailBroken? $jailBroken , Real phone? $isReal , Trusted? $isNotTrusted',
      );
      return !jailBroken || !isReal || isNotTrusted;
    } catch (e) {
      debugPrint('$e');
      return null;
    }
  }
}
