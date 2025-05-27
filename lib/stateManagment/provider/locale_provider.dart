import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Notifier/localeNotifier.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});
