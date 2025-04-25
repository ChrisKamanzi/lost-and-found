import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lost_and_found/widgets/elevated_button.dart';
import 'package:lost_and_found/widgets/text_field.dart';
import '../../constant/api.dart';
import '../../models/create_ad_model.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/categoryNotifier.dart';
import '../../providers/districtsNotifier.dart';

class CreateAdReg extends ConsumerStatefulWidget {
  const CreateAdReg({super.key});

  @override
  ConsumerState<CreateAdReg> createState() => _CreateAdRegState();
}

class _CreateAdRegState extends ConsumerState<CreateAdReg> {
  File? _image1;
  File? _image2;

  String? selectedLocation;
  String? selectedPostType;

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.read(categoryProvider.notifier).fetchCategories();
    ref.read(villageProvider.notifier).fetchVillages();
  }

  Future<void> _pickImage(int imageNumber) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        if (imageNumber == 1) {
          _image1 = File(pickedFile.path);
        } else {
          _image2 = File(pickedFile.path);
        }
      });
    }
  }

  Future<void> save(CreateAd createAdData) async {
    String url = "$apiUrl/items";
    Dio dio = Dio();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      final userId = prefs.getInt('userId');

      if (token == null || userId == null) {
        print('Missing token or userId. User might not be authenticated.');
        return;
      }

      final selectedCategory = ref.read(selectedCategoryProvider);

      FormData formData = FormData();

      formData.fields.addAll([
        MapEntry('title', createAdData.title),
        MapEntry('description', createAdData.description),
        MapEntry('post_type', createAdData.post_type),
        MapEntry('user_id', userId.toString()),
        if (selectedCategory != null)
          MapEntry('category_id', selectedCategory),
        if (createAdData.villageId.isNotEmpty)
          MapEntry('village_id', createAdData.villageId),
        if (createAdData.location.isNotEmpty)
          MapEntry('location', createAdData.location.first),
      ]);

      if (createAdData.image1 != null) {
        formData.files.add(MapEntry(
          'itemImages[]',
          await MultipartFile.fromFile(
            createAdData.image1!.path,
            filename: basename(createAdData.image1!.path),
          ),
        ));
      }

      if (createAdData.image2 != null) {
        formData.files.add(MapEntry(
          'itemImages[]',
          await MultipartFile.fromFile(
            createAdData.image2!.path,
            filename: basename(createAdData.image2!.path),
          ),
        ));
      }

      print('FormData fields: ${formData.fields}');
      print('FormData files: ${formData.files}');

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

      print('✅ Response: ${response.statusCode} - ${response.data}');
    } catch (e) {
      if (e is DioException) {
        print('❌ Dio error: ${e.response?.statusCode} - ${e.response?.data}');
      } else {
        print('❌ Unexpected error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final villages = ref.watch(villageProvider);

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create ad',
              style: GoogleFonts.brawler(
                textStyle: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Category Dropdown
            DropdownButtonFormField<String>(
              hint: Text('Category'),
              value: ref.watch(selectedCategoryProvider),
              items: categories.map((cat) {
                return DropdownMenuItem<String>(
                  value: cat['id'],
                  child: Text(
                    cat['name'],
                    style: const TextStyle(fontSize: 20),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                ref.read(selectedCategoryProvider.notifier).state = value;
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Post Type Dropdown
            DropdownButtonFormField<String>(
              hint: Text('Post Type'),
              value: selectedPostType,
              items: ['Lost', 'Found'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(fontSize: 20)),
                );
              }).toList(),
              onChanged: (value) => setState(() => selectedPostType = value),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Title TextField
            textfield(controller: _title, hintText: 'Title'),
            const SizedBox(height: 20),

            // Description TextField
            textfield(controller: _description, hintText: 'Description'),
            const SizedBox(height: 20),

            // Village Dropdown
            DropdownButtonFormField<String>(
              hint: Text('Village'),
              value: selectedLocation,
              items: villages.isNotEmpty
                  ? villages.map((village) {
                return DropdownMenuItem<String>(
                  value: village['id'],
                  child: Text(
                    village['name'],
                    style: const TextStyle(fontSize: 20),
                  ),
                );
              }).toList()
                  : [],
              onChanged: (value) {
                setState(() {
                  selectedLocation = value;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Image Upload Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Upload Image',
                  style: GoogleFonts.brawler(
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _pickImage(_image1 == null ? 1 : 2),
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.purple.shade100,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.purple, width: 2),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add_a_photo,
                        size: 30,
                        color: Colors.purple.shade700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 20),

            // Image Preview Section
            Row(
              children: [
                Container(
                  height: 150,
                  width: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.purple.shade200),
                  ),
                  child: _image1 != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(
                      _image1!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                      : Center(
                    child: Text(
                      'No image selected',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  height: 150,
                  width: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.purple.shade200),
                  ),
                  child: _image2 != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(
                      _image2!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                      : Center(
                    child: Text(
                      'Press that Icon 👆',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Done Button
            button(
              text: 'Done',
              onPressed: () {
                String? villageId = selectedLocation;

                CreateAd createAdData = CreateAd(
                  selectedCategory: selectedCategory ?? '',
                  post_type: selectedPostType == 'Lost' ? 'lost' : 'found',
                  title: _title.text.trim(),
                  description: _description.text.trim(),
                  location: selectedLocation != null ? [selectedLocation!] : [],
                  villageId: villageId!,
                  image1: _image1,
                  image2: _image2,
                );
                save(createAdData);
              },
            ),
          ],
        ),
      ),
    );
  }
}
