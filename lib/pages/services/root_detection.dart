import 'package:flutter/material.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';

class DeviceSecurityService {
  static Future<bool> isDeviceCompromised(BuildContext context) async {
    try {
      final bool jailBroken =
          await JailbreakRootDetection.instance.isJailBroken;
      final bool isRealDevice =
          await JailbreakRootDetection.instance.isRealDevice;
      final bool isTrusted = await JailbreakRootDetection.instance.isNotTrust;
      final bool compromised = jailBroken || !isRealDevice || isTrusted;
      debugPrint('Jailbroken? : $jailBroken');
      debugPrint('RealDevice? : $isRealDevice');
      debugPrint('Tursted?: $isTrusted');
      return compromised;
    } catch (e) {
      debugPrint('error : $e');
      return false;
    }
  }
}
