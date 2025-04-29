class User {
  final String name;
  final String email;
  final String telephone;
  final int id;

  User({
    required this.name,
    required this.email,
    required this.telephone,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      telephone: json['telephone'],
      id: json['id'],
    );
  }
}
