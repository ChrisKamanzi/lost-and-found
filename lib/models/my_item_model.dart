class MyItem {
  final String id;
  final String title;
  final String description;
  final String postType;
  final String postedAt;
  final String imageUrl;

  MyItem({
    required this.id,
    required this.title,
    required this.description,
    required this.postType,
    required this.postedAt,
    required this.imageUrl,
  });

  factory MyItem.fromJson(Map<String, dynamic> json) {
    return MyItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      postType: json['post_type'],
      postedAt: json['posted_at'],
      imageUrl: json['itemImages'].isNotEmpty
          ? json['itemImages'][0]['url']
          : '',
    );
  }
}
