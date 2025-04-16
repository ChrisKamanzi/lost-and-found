class lostFound {
  final String imagePath;
  final String location;
  final String lostStatus;
  final String daysAgo;

  lostFound({
    required this.imagePath,
    required this.location,
    required this.lostStatus,
    required this.daysAgo,
  });

  factory lostFound.fromJson(Map<String, dynamic> json) {
    String imagePath = '';

    if (json['itemImages'] != null &&
        json['itemImages'] is List &&
        json['itemImages'].isNotEmpty) {
      imagePath = json['itemImages'][0]['url'];
    }

    return lostFound(
      imagePath: imagePath,
      location: json['location'],
      lostStatus: json['post_type'],
      daysAgo: json['posted_at'],
    );
  }
}
