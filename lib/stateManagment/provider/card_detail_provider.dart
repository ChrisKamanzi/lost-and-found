import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/lost_found_model.dart';
import '../Notifier/card_detail_notifier.dart';

final cardDetailProvider = StateNotifierProvider.family<
  CardDetailNotifier,
  AsyncValue<LostFound>,
  String
>((ref, itemId) {
  final notifier = CardDetailNotifier();
  notifier.fetchItem(itemId);
  return notifier;
});
