import 'dart:io';

class CreateAdState {
  final String? selectedCategory;
  final String? postType;
  final String title;
  final String description;
  final List<String> location;
  final File? image1;
  final File? image2;
  final bool isLoading;
  final String? villageId;

  CreateAdState({
    this.selectedCategory,
    this.postType,
    this.title = '',
    this.description = '',
    this.location = const [],
    this.image1,
    this.image2,
    this.isLoading = false,
    this.villageId,
  });

  CreateAdState copyWith({
    String? selectedCategory,
    String? postType,
    String? title,
    String? description,
    List<String>? location,
    File? image1,
    File? image2,
    bool? isLoading,
    String? villageId,
  }) {
    return CreateAdState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      postType: postType ?? this.postType,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      image1: image1 ?? this.image1,
      image2: image2 ?? this.image2,
      isLoading: isLoading ?? this.isLoading,
      villageId: villageId ?? this.villageId,
    );
  }
}