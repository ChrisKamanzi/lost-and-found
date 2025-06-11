import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../pages/services/local_auth.dart';

class SplashNotifier extends StateNotifier<String?> {
  SplashNotifier() : super(null) {
    _init();
  }

  Future<void> _init() async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final faceIDEnabled = prefs.getBool('faceIDEnabled') ?? false;

    if (faceIDEnabled) {
      final authenticated = await AuthService.authenticate();
      if (authenticated) {
        state = isLoggedIn ? '/homepage' : '/language';
      } else {
        state = '/language';
      }
    } else {
      state = isLoggedIn ? '/homepage' : '/language';
    }
  }
}

final splashProvider = StateNotifierProvider<SplashNotifier, String?>(
      (ref) => SplashNotifier(),
);
