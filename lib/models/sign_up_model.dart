class SignUpModel {
  final String? name;
  final String? email;
  final String? password;
  final String? passwordConfirmation;
  final String? phone;
  final String? village;

  SignUpModel({
    this.name,
    this.email,
    this.password,
    this.passwordConfirmation,
    this.phone,
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
