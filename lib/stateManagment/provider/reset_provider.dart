import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/reset_password.dart';
import '../Notifier/reset_password_notifier.dart';

final resetProvider = StateNotifierProvider<ResetNotifier, ResetPasswordModel>(
      (ref) => ResetNotifier(),
);
