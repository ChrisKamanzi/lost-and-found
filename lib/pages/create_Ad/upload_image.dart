import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lost_and_found/widgets/drawer.dart';
import 'dart:io';
import 'package:lost_and_found/widgets/elevated_button.dart';

class uploadImage extends StatefulWidget {
  const uploadImage({super.key});

  @override
  State<uploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<uploadImage> {
  final ImagePicker _picker = ImagePicker();
  List<XFile?> images = [null, null, null, null];

  Future<void> _pickImage(int index) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      images[index] = image;
    });
  }

  Widget _buildImageContainer(int index) {
    return GestureDetector(
      onTap: () => _pickImage(index),
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.purple.shade200,
          image:
              images[index] != null
                  ? DecorationImage(
                    image: FileImage(File(images[index]!.path)),
                    fit: BoxFit.cover,
                  )
                  : null,
        ),
        child:
            images[index] == null
                ? const Center(
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white54,
                    size: 40,
                  ),
                )
                : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
      //  drawer: drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Picture',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
              ),
              SizedBox(height: 30),
              Text(
                'Add up to 3 pictures. Use real pictures and not catalogs.',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w200,
                  color: Colors.deepPurpleAccent.shade400,
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [_buildImageContainer(0), _buildImageContainer(1)],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [_buildImageContainer(2), _buildImageContainer(3)],
              ),
              SizedBox(height: 80),
              button(
                text: 'CONTINUE',
                onPressed: () => context.push('/requestor_info'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
