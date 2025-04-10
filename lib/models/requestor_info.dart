class Request_info {
  String name;
  String email;
  int phone;

  Request_info({required this.name, required this.email, required this.phone});

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'phone': phone};
  }
}
