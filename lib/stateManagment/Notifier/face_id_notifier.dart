import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/services/local_auth.dart';

class FaceIDNotifier extends StateNotifier<bool> {
  FaceIDNotifier() : super(false) {
    _loadFaceIDStatus();
  }

  Future<void> _loadFaceIDStatus() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('faceIDEnabled') ?? false;
  }

  Future<void> toggleFaceID(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value) {
      bool authenticated = await AuthService.authenticate();
      if (authenticated) {
        await prefs.setBool('faceIDEnabled', true);
        state = true;
      } else {
        state = false;
      }
    } else {
      await prefs.setBool('faceIDEnabled', false);
      state = false;
    }
  }
}

final faceIDProvider = StateNotifierProvider<FaceIDNotifier, bool>((ref) {
  return FaceIDNotifier();
});
