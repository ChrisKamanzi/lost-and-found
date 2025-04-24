class Category {
  final String name;

  Category({required this.name});

  factory Category.fromJson(Map<dynamic, dynamic> json) {
    return Category(
      name: json['name'] ?? '',
    );
  }
}
