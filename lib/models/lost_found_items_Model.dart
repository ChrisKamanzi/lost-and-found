class LostFoundItems {
  String id;
  String title;
  String description;
  Location? location;
  String postType;
  String postedAt;
  String category;
  PostedBy postedBy;
  List itemImage;

  LostFoundItems({
    required this.id,
    required this.title,
    required this.description,
    this.location,
    required this.postType,
    required this.postedAt,
    required this.category,
    required this.postedBy,
    required this.itemImage,
  });

  factory LostFoundItems.fromJson(Map<String, dynamic> json) => LostFoundItems(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    location:
        json['location'] != null ? Location.fromJson(json['location']) : null,
    postType: json['post_type'],
    postedAt: json['posted_at'],
    category: json['category'],
    postedBy: PostedBy.fromJson(json['posted_by']),
    itemImage: json['itemImages'],
  );
}

class Location {
  String? village;
  String? cell;
  String? sector;
  String? district;

  Location({this.village, this.cell, this.sector, this.district});

  factory Location.fromJson(Map<dynamic, dynamic> json) => Location(
    village: json["village"],
    cell: json["cell"],
    sector: json["sector"],
    district: json["district"],
  );
}

class PostedBy {
  int id;
  String name;
  bool? isMyItem;
  String? telephone;
  Location? location;

  PostedBy({
    required this.id,
    required this.name,
    this.telephone,
    this.isMyItem,
    this.location,
  });

  factory PostedBy.fromJson(Map<dynamic, dynamic> json) => PostedBy(
    id: json['id'],
    name: json['name'],
    isMyItem: json['is_myItem'],
    telephone: json['telephone'],
    location:
        json['location'] != null ? Location.fromJson(json['location']) : null,
  );
}
