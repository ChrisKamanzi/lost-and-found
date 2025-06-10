import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerState {
  final File? image1;
  final File? image2;
  final bool isFirstImageSelected;

  ImagePickerState({
    this.image1,
    this.image2,
    this.isFirstImageSelected = false,
  });

  ImagePickerState copyWith({
    File? image1,
    File? image2,
    bool? isFirstImageSelected,
  }) {
    return ImagePickerState(
      image1: image1 ?? this.image1,
      image2: image2 ?? this.image2,
      isFirstImageSelected: isFirstImageSelected ?? this.isFirstImageSelected,
    );
  }
}

class ImagePickerNotifier extends StateNotifier<ImagePickerState> {
  ImagePickerNotifier() : super(ImagePickerState());

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      if (!state.isFirstImageSelected) {
        state = state.copyWith(image1: file, isFirstImageSelected: true);
      } else {
        state = state.copyWith(image2: file);
      }
    }
  }

  void clearImages() {
    state = ImagePickerState(
      image1: null,
      image2: null,
      isFirstImageSelected: false,
    );
  }
}

final imagePickerProvider =
    StateNotifierProvider<ImagePickerNotifier, ImagePickerState>(
      (ref) => ImagePickerNotifier(),
    );
