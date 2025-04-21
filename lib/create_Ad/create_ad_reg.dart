import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:lost_and_found/widgets/elevated_button.dart';
import 'package:lost_and_found/widgets/text_field.dart';
import '../constant/api.dart';
import '../providers/create_ad_provider.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateAdReg extends ConsumerStatefulWidget {
  const CreateAdReg({super.key});

  @override
  ConsumerState<CreateAdReg> createState() => _CreateAdRegState();
}

class _CreateAdRegState extends ConsumerState<CreateAdReg> {
  File? _selectedImage;
  File? _image1;
  File? _image2;

  final List<Map<String, dynamic>> category = [
    {'id': '01js0j115bzntqafah5tdfqr977', 'name': 'Mobile'},
    {'id': '01js0j11szfyyc58c9h4z6xcwdd', 'name': 'Laptop'},
    {'id': '01js0j139g8007a55c2hxtqs077', 'name': 'Documents'},
  ];

  final List<String> location = ['Kigali', 'Lagos', 'Bujumbura'];

  String? selectedCategory;
  String? selectedLocation;
  String? selectedPostType;

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();

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

  void save() async {
    String url = "$apiUrl/items/store";

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      final userId = prefs.getInt('userId');

      if (token == null || userId == null) {
        print('Missing token or userId. User might not be authenticated.');
        return;
      }

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      request.fields['title'] = _title.text;
      request.fields['description'] = _description.text;
      request.fields['category_id'] = selectedCategory ?? '';
      request.fields['post_type'] =
          selectedPostType == 'Lost' ? 'lost' : 'found';
      request.fields['user_id'] = userId.toString();

      if (selectedLocation != null) {
        request.fields['location'] = selectedLocation!;
      }
      if (_image1 != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'itemImages[]',
            _image1!.path,
            filename: basename(_image1!.path),
          ),
        );
      }
      if (_image2 != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'itemImages[]',
            _image2!.path,
            filename: basename(_image2!.path),
          ),
        );
      }
      print('Sending category_id: ${request.fields['category_id']}');

      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);

      print('Response body: ${responseBody.body}');
      if (responseBody.statusCode == 200 || responseBody.statusCode == 201) {
        print('Success with status: ${responseBody.statusCode}');
      } else {
        print('Save failed with status: ${responseBody.statusCode}');
      }
    } catch (e) {
      print('️Error during save: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final createAd = ref.watch(createAdProvider);

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
            DropdownButtonFormField<String>(
              hint: Text('Category'),
              value: selectedCategory,
              items:
                  category.map((cat) {
                    return DropdownMenuItem<String>(
                      value: cat['id'], // use the ID here
                      child: Text(
                        cat['name'],
                        style: const TextStyle(fontSize: 20),
                      ),
                    );
                  }).toList(),
              onChanged: (value) => setState(() => selectedCategory = value),
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
            DropdownButtonFormField<String>(
              hint: Text('Post Type'),
              value: selectedPostType,
              items:
                  ['Lost', 'Found'].map((String value) {
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
            textfield(controller: _title, hintText: 'Title'),
            const SizedBox(height: 20),
            textfield(controller: _description, hintText: 'Description'),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              hint: Text('Location'),
              value: selectedLocation,
              items:
                  location.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: const TextStyle(fontSize: 20)),
                    );
                  }).toList(),
              onChanged: (value) => setState(() => selectedLocation = value),
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
                const SizedBox(width: 20),
                Container(
                  height: 150,
                  width: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.purple.shade200),
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
                              'Press that Icon 👆'
                              '',
                              style: TextStyle(color: Colors.grey.shade700),
                            ),
                          ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            button(text: 'Done', onPressed: save),
          ],
        ),
      ),
    );
  }
}
