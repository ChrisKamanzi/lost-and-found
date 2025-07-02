import 'package:jailbreak_root_detection/jailbreak_root_detection.dart';

class DeviceSecurityService{

  final JailbreakRootDetection detection;

  DeviceSecurityService({JailbreakRootDetection? detection})
      : detection = detection ?? JailbreakRootDetection.instance;

  Future<bool> isDeviceCompromised() async {

    try {
      final jailBroken = await detection.isJailBroken;
      final isReal = await detection.isRealDevice;
      final isNotTrusted = await detection.isNotTrust;
      return jailBroken || !isReal || isNotTrusted;
    } catch (_) {
      return false;
    }
  }
}
