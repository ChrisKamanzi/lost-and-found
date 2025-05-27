import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/map_state_model.dart';
import '../Notifier/map_item_notifier.dart';

final mapItemProvider = StateNotifierProvider<MapItemNotifier, MapState>(
      (ref) => MapItemNotifier(),
);
