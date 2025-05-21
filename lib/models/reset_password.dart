class ResetPasswordModel {
  final String? token;
  final String? email;
  final String? password;
  final String? passwordConfirmation;

  ResetPasswordModel({
    this.token,
    this.email,
    this.password,
    this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
  }
}
