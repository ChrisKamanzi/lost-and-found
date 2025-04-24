class lostFound {
  final String id;
  final String title;
  final String description;
  final String location;
  final String postType;
  final String postedAt;
  final String categoryName;
  final String name;
  final String email;
  final String telephone;
  final String imagePath;
  final int userId;

  lostFound({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.postType,
    required this.postedAt,
    required this.categoryName,
    required this.name,
    required this.email,
    required this.telephone,
    required this.imagePath,
    required this.userId,
  });

  factory lostFound.fromJson(Map<dynamic, dynamic> json) {
    final user = json['user'] ?? {};
    final category = json['category'] ?? {};
    final images = json['itemImages'] as List<dynamic>? ?? [];

    return lostFound(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      location: json['location'],
      postType: json['post_type'],
      postedAt: json['posted_at'],
      categoryName: category['name'] ?? '',
      name: user['name'] ?? '',
      email: user['email'] ?? '',
      telephone: user['telephone'] ?? '',
      imagePath: images.isNotEmpty
          ? 'https://yourdomain.com${images[0]['url']}'
          : '',
      userId: user['id'] ?? 0,
    );
  }
}
