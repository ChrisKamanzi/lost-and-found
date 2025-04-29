class SignUpModel {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String phone;
  final String? village;

  SignUpModel({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.phone,
    this.village,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'phone_number': phone,
      'village_id': village,
    };
  }
}
