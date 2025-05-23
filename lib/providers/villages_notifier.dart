import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_and_found/constant/api.dart';

class VillageNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  final Dio dio;

  VillageNotifier(this.dio) : super([]);

  Future<void> fetchVillages() async {
    try {
      final response = await dio.get(
        "$apiUrl/villages",
        options: Options(headers: {'Accept': 'application/json'}),
      );
      if (response.statusCode == 200) {
        state = List<Map<String, dynamic>>.from(response.data['villages']);
      }
    } catch (e) {
      print("Error fetching villages: $e");
    }
  }
}

final dioProvider = Provider((ref) {
  return Dio(BaseOptions(headers: {'Accept': 'application/json'}));
});

final villageProvider =
    StateNotifierProvider<VillageNotifier, List<Map<String, dynamic>>>((ref) {
      final dio = ref.watch(dioProvider);
      return VillageNotifier(dio);
    });

final selectedVillageProvider = StateProvider<String?>((ref) => null);
