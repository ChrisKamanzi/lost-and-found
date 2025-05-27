import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/login_model.dart';
import '../Notifier/login_notifier.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginModel>((ref) =>
    LoginNotifier(),
);
