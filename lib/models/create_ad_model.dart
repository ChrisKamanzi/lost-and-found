import 'dart:io';

class CreateAd {
  String selectedCategory;
  String post_type;
  String title;
  String description;
  List<String> location;
  final File? image1;
  final File? image2;

  CreateAd({
    required this.selectedCategory,
    required this.post_type,
    required this.title,
    required this.description,
    required this.location,
    this.image1,
    this.image2,
  });

  Map<String, dynamic> toJson() {
    return {
      'category': selectedCategory,
      'post_type': post_type,
      'title': title,
      'description': description,
      'location': location,
    };
  }
}
