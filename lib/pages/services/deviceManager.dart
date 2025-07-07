import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class Devicemanager {
  static Future<String?> getDeviceId() async {
    DeviceInfoPlugin deviceinfo = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo android = await deviceinfo.androidInfo;
        return android.id;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceinfo.iosInfo;
        return iosInfo.identifierForVendor;
      } else {
        return "Unsupported platform";
      }
    } catch (e) {
      print('failed to fetch the ID : $e');
      return null;
    }
  }
}
