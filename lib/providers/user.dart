import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_and_found/providers/userNotifier.dart';

import '../models/emailModel.dart';

final emailProvider = StateNotifierProvider<EmailNotifier, Account?>(
      (ref) => EmailNotifier()..fetchEmail(),
);
