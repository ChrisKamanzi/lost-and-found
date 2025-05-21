class LoginModel {
  String? email;
  String? password;

  LoginModel({this.email,  this.password});

  Map<String, String> toJson() {
    return {'email': email ?? '', 'password': password ?? ''};
  }
}
