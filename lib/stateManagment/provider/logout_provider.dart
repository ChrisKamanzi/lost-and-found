import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Notifier/logout_notifier.dart';

final logoutNotifierProvider =
StateNotifierProvider<LogoutNotifier, AsyncValue<void>>((ref) {
  return LogoutNotifier();
});
