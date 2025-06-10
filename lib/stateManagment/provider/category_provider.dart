import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Notifier/category_notifier.dart';

final dioProvider = Provider((ref) {
  return Dio(BaseOptions(headers: {'Accept': 'application/json'}));
});

final categoryProvider = StateNotifierProvider<CategoryNotifier, List<Map<String, dynamic>>>((ref) {
  final dio = ref.watch(dioProvider);
  return CategoryNotifier(dio);
});

final selectedCategoryProvider = StateProvider<String?>((ref) => null);

final categoryErrorProvider = Provider<String?>((ref) {
  return ref.watch(categoryProvider.notifier).errorMessage;
});