import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/sign_up_model.dart';
import '../Notifier/sign_up_notifier.dart';

final signUpProvider =
StateNotifierProvider<SignUpNotifier, SignUpModel>((ref) {
  return SignUpNotifier();
});

