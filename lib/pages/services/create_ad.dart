import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import '../../models/create_ad_model.dart';

final createAdNotifierProvider =
    StateNotifierProvider<CreateAdNotifier, AsyncValue<void>>((ref) {
      return CreateAdNotifier(ref);
    });

class CreateAdNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  CreateAdNotifier(this.ref) : super(const AsyncValue.data(null));



  String get apiUrl {
    final url = dotenv.env['apiUrl'];
    if (url == null) throw Exception('API URL not set');
    return url;
  }
  Future<String?> save(CreateAd createAdData) async {
    state = const AsyncValue.loading();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      final userId = prefs.getInt('userId');

      if (token == null || userId == null) {
        state = const AsyncValue.data(null);
        return 'You are not authenticated.';
      }

      final formData = FormData();

      if (createAdData.image1 != null) {
        formData.files.add(
          MapEntry(
            'itemImages[]',
            await MultipartFile.fromFile(
              createAdData.image1!.path,
              filename: basename(createAdData.image1!.path),
            ),
          ),
        );
      }

      if (createAdData.image2 != null) {
        formData.files.add(
          MapEntry(
            'itemImages[]',
            await MultipartFile.fromFile(
              createAdData.image2!.path,
              filename: basename(createAdData.image2!.path),
            ),
          ),
        );
      }

      formData.fields.addAll([
        MapEntry('title', createAdData.title ?? ''),
        MapEntry('description', createAdData.description ?? ''),
        MapEntry('post_type', createAdData.post_type ?? ''),
        MapEntry('village_id', createAdData.villageId ?? ''),
        MapEntry('category_id', createAdData.selectedCategory ?? ''),
        MapEntry('user_id', userId.toString()),
        if (createAdData.location.isNotEmpty)
          MapEntry('location', createAdData.location.first),
      ]);

      final dio = Dio();

      final response = await dio.post(
        '$apiUrl/items',
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        state = AsyncValue.data(null);
        return null; // success
      } else {
        state = AsyncValue.data(null);
        return 'Failed to create ad: ${response.data['message'] ?? 'Unknown error'}';
      }
    } on DioException catch (e) {
      state = AsyncValue.data(null);
      if (e.type == DioExceptionType.connectionTimeout) {
        return 'Connection timeout. Please check your internet.';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        return 'Server took too long to respond.';
      } else if (e.type == DioExceptionType.badResponse) {
        return 'Failed to create ad: ${e.response?.data['message'] ?? 'Server error'}';
      } else if (e.type == DioExceptionType.unknown) {
        return 'No internet connection or unexpected network error.';
      } else {
        return 'Unexpected Dio error: ${e.message}';
      }
    } catch (e) {
      state = AsyncValue.data(null);
      return 'Check your Connection Please ';
    }
  }
}
