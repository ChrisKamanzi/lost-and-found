import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lost_and_found/constant/api.dart';
import 'package:lost_and_found/widgets/text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/ResetPassword.dart';
import '../../widgets/elevated_button.dart';

class TokenPage extends StatelessWidget {
  const TokenPage({super.key});


  Future<void> _Token(
      ResetPasswordModel resetPasswordData,
      BuildContext context,
      ) async {
    String loginUrl = "$apiUrl/reset-password";
    Dio dio = Dio();

    try {
      final response = await dio.post(
        loginUrl,
        data: resetPasswordData.toJson(),
      );

      print('Response body: ${response.data}');
      if (response.statusCode == 200) {
        final data = response.data;
        print('Success: $data');
        context.go('/homepage');
      } else {
        print('Login reset password failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    TextEditingController _token = TextEditingController();
    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();
    TextEditingController _passwordConfirmation = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  'RESET PASSWORD',
                  style: GoogleFonts.brawler(
                    textStyle: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.orangeAccent
                          : Colors.black,                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Text(
                'TOKEN',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.orangeAccent
                        : Colors.black,                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 20),
              textfield(controller: _token),

              SizedBox(height: 20),
              Text(
                'EMAIL',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.orangeAccent
                        : Colors.black,                        fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 20),
              textfield(controller: _email),

              SizedBox(height: 20),
              Text(
                'Password',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.orangeAccent
                        : Colors.black,                        fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 20),
              textfield(controller: _password),

              SizedBox(height: 20),
              Text(
                'PASSWORD CONFIRMATION',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.orangeAccent // custom color for dark mode
                        : Colors.black,                        fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 20),
              textfield(controller: _passwordConfirmation),

              SizedBox(height: 20),
              Align(
                alignment: Alignment.topRight,
                child: button(
                  text: 'Reset Password',
                  onPressed: () {
                    ResetPasswordModel resetPasswordData = ResetPasswordModel(
                      token: _token.text.trim(),
                      email: _email.text.trim(),
                      password: _password.text.trim(),
                      passwordConfirmation: _passwordConfirmation.text.trim(),
                    );

                    _Token(resetPasswordData, context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
