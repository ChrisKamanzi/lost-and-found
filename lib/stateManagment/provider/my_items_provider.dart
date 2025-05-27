import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/my_item_model.dart';
import '../Notifier/my_item_notifier.dart';

final myItemsNotifierProvider =
StateNotifierProvider<MyItemsNotifier, AsyncValue<List<MyItem>>>(
      (ref) => MyItemsNotifier(),
);