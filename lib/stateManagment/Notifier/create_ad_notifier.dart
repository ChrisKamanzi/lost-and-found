import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constant/api.dart';
import '../../models/create.dart';


  class CreateAdNotifier extends StateNotifier<CreateAdState> {
  CreateAdNotifier() : super(CreateAdState());

  Future<void> save(BuildContext context) async {
    if (state.isLoading) return;

    String url = "$apiUrl/items";
    Dio dio = Dio();
    state = state.copyWith(isLoading: true);

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      final userId = prefs.getInt('userId');

      if (token == null || userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You are not authenticated.')),
        );
        return;
      }

      FormData formData = FormData();

      formData.fields.addAll([
        MapEntry('title', state.title),
        MapEntry('description', state.description),
        MapEntry('post_type', state.postType ?? ''),
        MapEntry('user_id', userId.toString()),
        if (state.selectedCategory != null)
          MapEntry('category_id', state.selectedCategory!),
        if (state.villageId != null) MapEntry('village_id', state.villageId!),
        if (state.location.isNotEmpty)
          MapEntry('location', state.location.first),
      ]);

      if (state.image1 != null) {
        formData.files.add(
          MapEntry(
            'itemImages[]',
            await MultipartFile.fromFile(
              state.image1!.path,
              filename: basename(state.image1!.path),
            ),
          ),
        );
      }

      if (state.image2 != null) {
        formData.files.add(
          MapEntry(
            'itemImages[]',
            await MultipartFile.fromFile(
              state.image2!.path,
              filename: basename(state.image2!.path),
            ),
          ),
        );
      }

      final response = await dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ad successfully created!')),
        );
        state = CreateAdState();
      }
    } catch (e) {
      if (e is DioError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error: ${e.response?.data['message'] ?? 'Failed to post'}',
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unexpected error occurred.')),
        );
      }
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void updateCategory(String? category) {
    state = state.copyWith(selectedCategory: category);
  }

  void updatePostType(String? postType) {
    state = state.copyWith(postType: postType);
  }

  void updateLocation(String? location) {
    state = state.copyWith(location: [location ?? '']);
  }

  void updateTitle(String title) {
    state = state.copyWith(title: title);
  }

  void updateDescription(String description) {
    state = state.copyWith(description: description);
  }

  void updateVillageId(String? villageId) {
    state = state.copyWith(villageId: villageId);
  }

  void updateImage1(File? image1) {
    state = state.copyWith(image1: image1);
  }

  void updateImage2(File? image2) {
    state = state.copyWith(image2: image2);
  }
}
