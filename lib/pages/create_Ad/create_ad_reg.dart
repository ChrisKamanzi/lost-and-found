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
import '../../providers/VillagesNotifier.dart';

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
  bool _isLoading = false;

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

  Future<void> save(CreateAd createAdData, BuildContext context) async {
    String url = "$apiUrl/items";
    Dio dio = Dio();

    try {
      setState(() => _isLoading = true);

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      final userId = prefs.getInt('userId');

      if (token == null || userId == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('You are not authenticated.')));
        return;
      }

      final selectedCategory = ref.read(selectedCategoryProvider);
      FormData formData = FormData();

      formData.fields.addAll([
        MapEntry('title', createAdData.title),
        MapEntry('description', createAdData.description),
        MapEntry('post_type', createAdData.post_type),
        MapEntry('user_id', userId.toString()),
        if (selectedCategory != null) MapEntry('category_id', selectedCategory),
        if (createAdData.villageId.isNotEmpty)
          MapEntry('village_id', createAdData.villageId),
        if (createAdData.location.isNotEmpty)
          MapEntry('location', createAdData.location.first),
      ]);

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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ad successfully created!')));

        setState(() {
          _title.clear();
          _description.clear();
          _image1 = null;
          _image2 = null;
          selectedPostType = null;
          selectedLocation = null;
          ref.read(selectedCategoryProvider.notifier).state = null;
        });
      }
    } catch (e) {
      if (e is DioException) {
        print('Dio error: ${e.response?.statusCode} - ${e.response?.data}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error: ${e.response?.data['message'] ?? 'Failed to post'}',
            ),
          ),
        );
      } else {
        print('Unexpected error: $e');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Unexpected error occurred.')));
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final villages = ref.watch(villageProvider);

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'Create ad',
                  style: GoogleFonts.brawler(
                    textStyle: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.orangeAccent
                              : Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                DropdownButtonFormField<String>(
                  hint: Text(
                    'Category',
                    style: TextStyle(
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.black
                              : Colors.blueGrey,
                    ),
                  ),
                  value: selectedCategory,
                  items:
                      categories.map((cat) {
                        return DropdownMenuItem<String>(
                          value: cat['id'],
                          child: Text(
                            cat['name'],
                            style: TextStyle(fontSize: 20),
                          ),
                        );
                      }).toList(),
                  onChanged: (value) {
                    ref.read(selectedCategoryProvider.notifier).state = value;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  hint: Text(
                    'Post Type',
                    style: TextStyle(
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.black
                              : Colors.blueGrey,
                    ),
                  ),
                  value: selectedPostType,
                  items:
                      ['Lost', 'Found'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TextStyle(fontSize: 20)),
                        );
                      }).toList(),
                  onChanged:
                      (value) => setState(() => selectedPostType = value),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                textfield(controller: _title, hintText: 'Title'),
                SizedBox(height: 20),
                textfield(controller: _description, hintText: 'Description'),
                SizedBox(height: 20),

                Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: DropdownButtonFormField<String>(
                      hint: Text('Village'),
                      value: selectedLocation,
                      items:
                          villages.map((village) {
                            return DropdownMenuItem<String>(
                              value: village['id'],
                              child: Text(
                                village['name'],
                                style: const TextStyle(fontSize: 20),
                              ),
                            );
                          }).toList(),
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
                  ),
                ),
                SizedBox(height: 20),

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
                          color: Colors.orange.shade700,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.purpleAccent,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add_a_photo,
                            size: 30,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                Row(
                  children: [
                    Container(
                      height: 150,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.orange.shade700),
                      ),
                      child:
                          _image1 != null
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
                    SizedBox(width: 20),
                    Container(
                      height: 150,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.orange.shade700),
                      ),
                      child:
                          _image2 != null
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
                SizedBox(height: 20),

                button(
                  text: 'Done',
                  onPressed: () {
                    if (selectedPostType == null || selectedLocation == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill all fields')),
                      );
                      return;
                    }

                    CreateAd createAdData = CreateAd(
                      selectedCategory: selectedCategory ?? '',
                      post_type: selectedPostType == 'Lost' ? 'lost' : 'found',
                      title: _title.text.trim(),
                      description: _description.text.trim(),
                      location: [selectedLocation!],
                      villageId: selectedLocation!,
                      image1: _image1,
                      image2: _image2,
                    );

                    save(createAdData, context);
                  },
                ),
                SizedBox(height: 40),
              ],
            ),
          ),

          if (_isLoading)
            Container(
              color: Colors.black45,
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
