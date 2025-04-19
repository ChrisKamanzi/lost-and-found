class lostFound {
  final String title;
  final String imagePath;
  final String location;
  final String lostStatus;
  final String daysAgo;

  lostFound({
    required this.title,
    required this.imagePath,
    required this.location,
    required this.lostStatus,
    required this.daysAgo,
  });

  factory lostFound.fromJson(Map<String, dynamic> json) {
    final List images = json['itemImages'] ?? [];
    final String imagePath = images.isNotEmpty ? images[0]['url'] ?? '' : '';

    return lostFound(
      title: json['title'] ?? '',
      imagePath: imagePath,
      location: json['location'] ?? '',
      lostStatus: json['post_type'] ?? '',
      daysAgo: json['posted_at'] ?? '',
    );
  }
}
