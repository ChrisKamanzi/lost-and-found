class CreateAd {
  List<String> selected_category;

  // String post_type;
  String title;
  String Description;
  List<String> Location;

  CreateAd({
    required this.selected_category,
    //  required this.post_type,
    required this.title,
    required this.Description,
    required this.Location,
  });

  Map<String, String> toMap() {
    return {
      'selected_category': selected_category.join(','),
      'title': title,
      'Description': Description,
      'Location': Location.join(','),
    };
  }
}
