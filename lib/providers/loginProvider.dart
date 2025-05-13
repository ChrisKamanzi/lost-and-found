import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/login_model.dart';
import 'loginNotifier.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginModel>((ref) =>
    LoginNotifier(),
);
