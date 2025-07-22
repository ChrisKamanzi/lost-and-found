import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';

class DeviceInfo {
  final String deviceId;
  final String? model;
  final String name;

  DeviceInfo({required this.deviceId, this.model, required this.name});

  Map<String, dynamic> toJson() => {
    "deviceId": deviceId,
    "model": model,
    "name": name,
  };

  factory DeviceInfo.fromjson(Map<String, dynamic> json) {
    return DeviceInfo(
      deviceId: json['deviceId'] as String,
      name: json['name'] as String,
      model: json['name'] as String,
    );
  }
}

class DeviceManager {
  static Future<DeviceInfo> getDeviceInfo({bool showLogs = false}) async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final android = await deviceInfo.androidInfo;
        var info = DeviceInfo(
          deviceId: android.id,
          name: android.name,
          model: android.model,
        );

        if (showLogs) {
          debugPrint("${info.toJson()}");
        }
        return info;
      } else if (Platform.isIOS) {
        IosDeviceInfo ios = await deviceInfo.iosInfo;

        var info = DeviceInfo(
          deviceId: ios.identifierForVendor.toString(),
          name: ios.name,
          model: ios.model,
        );

        if (showLogs) {
          debugPrint("${info.toJson()}");
        }
        return info;
      } else {
        var error = DeviceInfo(
          deviceId: 'Unsupported',
          name: 'Unsupported',
          model: 'Unsupported',
        );
        return error;
      }
    } catch (e) {
      if (showLogs) debugPrint('Failed to fetch device info: $e');
      throw Exception("Failed to fetch info");
    }
  }
}
