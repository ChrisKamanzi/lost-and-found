import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import '../../models/create_ad_model.dart';
import '../../constant/api.dart';
import '../../stateManagment/provider/category_provider.dart';

final createAdNotifierProvider = StateNotifierProvider<CreateAdNotifier, bool>((ref,){

  return CreateAdNotifier(ref);

});

class CreateAdNotifier extends StateNotifier<bool> {

  final Ref ref;

  CreateAdNotifier(this.ref) : super(false);

  Future<String?> save(CreateAd createAdData) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final userId = prefs.getInt('userId');
    if (token == null || userId == null) {
      return 'You are not authenticated.';
    }
    final selectedCategory = ref.read(selectedCategoryProvider);
    FormData formData = FormData();
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
      MapEntry('title', createAdData.title!),
      MapEntry('description', createAdData.description!),
      MapEntry('post_type', createAdData.post_type!),
      MapEntry('village_id', createAdData.villageId!),
      if (createAdData.location.isNotEmpty)
        MapEntry('location', createAdData.location.first),
      MapEntry('category_id', selectedCategory ?? ''),
      MapEntry('user_id', userId.toString()),
    ]);
    try {
      state = true;
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
        debugPrint('It worked');
        return null;
      } else {
        return 'Failed to create ad';
      }
    } on DioException catch (e) {
      debugPrint('the error is $e ');
      return e.response?.data['message'] ?? 'Failed to post';
    } catch (e) {
      return 'Unexpected error occurred.';
    } finally {
      state = false;
    }
  }
}
