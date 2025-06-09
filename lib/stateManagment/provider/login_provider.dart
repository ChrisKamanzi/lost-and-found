import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Notifier/login_notifier.dart';

final loginProvider =    AsyncNotifierProvider<LoginNotifier, void>(() => LoginNotifier());
