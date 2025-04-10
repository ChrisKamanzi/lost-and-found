class CreateAd {
  List<String> selectedCategory;

  // String post_type;
  String title;
  String description;
  List<String> location;

  CreateAd({
    required this.selectedCategory,
    //  required this.post_type,
    required this.title,
    required this.description,
    required this.location,
  });

  Map<String, dynamic> toJson() {
    return {
      'selected_category': selectedCategory.toList(),
      'title': title,
      'Description': description,
      'Location': location.toList()
    };
  }
}
