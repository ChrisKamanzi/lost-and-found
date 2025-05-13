import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_and_found/models/items.dart';
import 'package:lost_and_found/providers/items_notifier.dart';

var lostFoundItemsProvider = StateNotifierProvider<ItemsNotifier, List<Items>?>(
  (ref) => ItemsNotifier(),
);
