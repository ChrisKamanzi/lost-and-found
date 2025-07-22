import 'Notifier/splash_notifier.dart';

class FakeSplashNotifier extends SplashNotifier {
  FakeSplashNotifier() {
    state = null; // or '/login', '/home', etc.
  }
}
