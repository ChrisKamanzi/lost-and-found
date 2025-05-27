import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Notifier/villages_notifier.dart';

final dioProvider = Provider((ref) {
  return Dio(BaseOptions(headers: {'Accept': 'application/json'}));
});

final villageProvider =
StateNotifierProvider<VillageNotifier, List<Map<String, dynamic>>>((ref) {
  final dio = ref.watch(dioProvider);
  return VillageNotifier(dio);
});
