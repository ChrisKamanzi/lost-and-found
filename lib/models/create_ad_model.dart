import 'dart:io';

class CreateAd {
  final String? selectedCategory;
  final String? post_type;
  final String? title;
  final String? description;
  final List<String> location;
  final File? image1;
  final File? image2;
  final String? villageId;

  CreateAd({
    this.selectedCategory,
    this.post_type,
    this.title,
    this.description,
    required this.location,
    this.image1,
    this.image2,
    this.villageId,
  });

  Map<String, dynamic> toJson() {
    return {
      'category_id': selectedCategory,
      'post_type': post_type,
      'title': title,
      'description': description,
      'location': location,
      'village_id': villageId,
    };
  }
}
