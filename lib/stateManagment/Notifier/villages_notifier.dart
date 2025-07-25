import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VillageNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  final Dio dio;

  VillageNotifier(this.dio) : super([]);
  String? errorMessage;


  String get apiUrl {
    final url = dotenv.env['apiUrl'];
    if (url == null) throw Exception('API URL not set');
    return url;
  }

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
      if (e is DioError) {
        errorMessage =
            e.response?.data['message'] ??
            'Something went wrong. Please try again.';
      } else {
        errorMessage = 'An unexpected error occurred.';
      }
    }
  }
}

final selectedVillageProvider = StateProvider<String?>((ref) => null);
