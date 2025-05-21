class LostFound {
  final String? id;
  final String? title;
  final String? description;
  final Map<String, String> location;
  final String? postType;
  final String? postedAt;
  final String? categoryName;
  final String? name;
  final String? email;
  final String? telephone;
  final String? imagePath;
  final int? userId;

  LostFound({
    this.id,
    this.title,
    this.description,
    required this.location,
    this.postType,
    this.postedAt,
    this.categoryName,
    this.name,
    this.email,
    this.telephone,
    this.imagePath,
    this.userId,
  });

  factory LostFound.fromJson(Map<dynamic, dynamic> json) {
    final postedBy = json['posted_by'] ?? {};
    final images = json['itemImages'] as List<dynamic>? ?? [];

    final rawImagePath = images.isNotEmpty ? images[0]['url'] ?? '' : '';
    final fullImagePath =
        (rawImagePath.startsWith('http') || rawImagePath.startsWith('https'))
            ? rawImagePath.trim()
            : 'https://5e45-2c0f-eb68-206-7c00-b118-81c3-6929-916c.ngrok-free.app/${rawImagePath.startsWith('/') ? rawImagePath : '/$rawImagePath'}'
                .trim();

    return LostFound(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      location: Map<String, String>.from(json['location'] ?? {}),
      postType: json['post_type'] ?? '',
      postedAt: json['posted_at'] ?? '',
      categoryName: json['category'] ?? '',
      name: postedBy['name'] ?? '',
      email: '',
      telephone: postedBy['telephone'] ?? '',
      imagePath: fullImagePath,
      userId: postedBy['id'] ?? 0,
    );
  }
}
