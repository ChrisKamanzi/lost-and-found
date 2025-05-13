class Account {
  int id;
  String? name;
  int? phone;
  String? email;

  Account({required this.id, this.name, this.phone, this.email});

  factory Account.fromJson(Map<String, dynamic> json) => Account(
    id: json['id'],
    name: json['name'],
    phone: json['phone'],
    email: json['email'],
  );
}

