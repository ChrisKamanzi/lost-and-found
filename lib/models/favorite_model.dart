class FavoriteItem {
  final String? id, title, description, postType, postedAt, category, imageUrl;
  final Location? location;
  final Poster? postedBy;

  FavoriteItem({
    this.id,
    this.title,
    this.description,
    this.postType,
    this.postedAt,
    this.category,
    this.imageUrl,
    this.location,
    this.postedBy,
  });

  factory FavoriteItem.fromJson(Map<String, dynamic> json) {
    return FavoriteItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      postType: json['post_type'],
      postedAt: json['posted_at'],
      category: json['category'],
      imageUrl: json['itemImages'][0]['url'],
      location: Location.fromJson(json['location']),
      postedBy: Poster.fromJson(json['posted_by']),
    );
  }
}

class Location {
  final String village, cell, sector, district;

  Location({
    required this.village,
    required this.cell,
    required this.sector,
    required this.district,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    village: json['village'],
    cell: json['cell'],
    sector: json['sector'],
    district: json['district'],
  );
}

class Poster {
  final int id;
  final String name, telephone;
  final bool isMyItem;
  final Location location;

  Poster({
    required this.id,
    required this.name,
    required this.telephone,
    required this.isMyItem,
    required this.location,
  });

  factory Poster.fromJson(Map<String, dynamic> json) => Poster(
    id: json['id'],
    name: json['name'],
    telephone: json['telephone'],
    isMyItem: json['is_myItem'],
    location: Location.fromJson(json['location']),
  );
}
