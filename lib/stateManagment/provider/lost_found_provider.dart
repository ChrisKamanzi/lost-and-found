import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../pages/services/lost_found_state.dart';
import '../Notifier/lost_found_items_notifier.dart';

final lostFoundNotifierProvider =
StateNotifierProvider<LostFoundNotifier, LostFoundState>((ref) {
  final repo = ref.watch(lostFoundRepositoryProvider);
  return LostFoundNotifier(repo)..init();
});
