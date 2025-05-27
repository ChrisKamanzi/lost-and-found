import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/map_model.dart';
import '../Notifier/map_notifier.dart';

final mapProvider = StateNotifierProvider<MapNotifier, MapState>(
      (ref) => MapNotifier(),
);
