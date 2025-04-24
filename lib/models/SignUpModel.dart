import 'package:lost_and_found/models/DistrictModel.dart';

class SignUpModel {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String phone;
  final DistrictModel district;

  SignUpModel({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.phone,
    required this.district,

  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'phone': phone,
      'district_id': district.id,
    };
  }
}
