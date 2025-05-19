import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/Create.dart';
import 'createAdNotifier.dart';

final createAdProvider = StateNotifierProvider<CreateAdNotifier, CreateAdState>(
  (ref) => CreateAdNotifier(),
);
