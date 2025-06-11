import 'package:local_auth/local_auth.dart';

class AuthService {
  static final LocalAuthentication _auth = LocalAuthentication();

  static Future<bool> _canAuthenticate() async {
    final bool isSupported = await _auth.isDeviceSupported();
    final bool hasBiometrics = await _auth.canCheckBiometrics;
    return isSupported && hasBiometrics;
  }

  static Future<bool> authenticate() async {
    try {
      if (!await _canAuthenticate()) return false;
      return await _auth.authenticate(
        localizedReason: "Please use Face ID for authentication",
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      print("Authentication Error: $e");
      return false;
    }
  }
}
