import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';

class RootDetection {
  final bool jailbroken;
  final bool isReal;
  final bool trusted;

  RootDetection({
    required this.jailbroken,
    required this.isReal,
    required this.trusted,
  });

  Map<String, dynamic> toJson() => {
    "jailbroken": jailbroken,
    "real": isReal,
    "trusted": trusted,
  };
}

class DeviceSecurity {
  static Future<bool?> isDeviceCompromised({bool showLogs = false}) async {
    if (kDebugMode && !showLogs) {
      debugPrint("Running in debug mode");
      return false;
    }
    final detector = JailbreakRootDetection.instance;
    try {
      final jailBroken = await detector.isJailBroken;
      final isReal = await detector.isRealDevice;
      final isNotTrusted = await detector.isNotTrust;

      var data = RootDetection(
        jailbroken: jailBroken,
        isReal: isReal,
        trusted: isNotTrusted,
      );
      if(showLogs)
        debugPrint(
            "${data.toJson()}"
        );
      return true;
    } catch (e) {
      debugPrint('Error checking device security: $e');
      return null;
    }
  }
}
