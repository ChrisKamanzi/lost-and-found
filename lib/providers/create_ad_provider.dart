import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/create.dart';
import 'create_ad_notifier.dart';

final createAdProvider = StateNotifierProvider<CreateAdNotifier, CreateAdState>(
  (ref) => CreateAdNotifier(),
);
