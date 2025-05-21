import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_and_found/models/lost_found_items_Model.dart';
import 'package:lost_and_found/providers/items_notifier.dart';

var lostFoundItemsProvider = StateNotifierProvider<ItemsNotifier, List<LostFoundItems>?>(
  (ref) => ItemsNotifier(),
);
