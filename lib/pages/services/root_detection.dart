import 'package:flutter/material.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';

class DeviceSecurityService {
  static Future<bool> isDeviceCompromised(BuildContext context) async {
    try {
      final bool jailbroken =
          await JailbreakRootDetection.instance.isJailBroken;
      final bool isRealDevice = await JailbreakRootDetection.instance.isRealDevice;

      final bool isTrusted = await JailbreakRootDetection.instance.isNotTrust;

      final bool compromised = jailbroken || !isRealDevice || isTrusted;

      return compromised;
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Security check failed: $e'),
          backgroundColor: Colors.orange,
        ),
      );
      return false;
    }
  }
}
