import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lost_and_found/constant/api.dart';
import 'package:lost_and_found/widgets/text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/reset_password.dart';
import '../../widgets/elevated_button.dart';

class TokenPage extends StatelessWidget {
  const TokenPage({super.key});

  Future<void> Token(
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
        print(
          'Login reset password failed with status: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController token = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController passwordConfirmation = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  'RESET PASSWORD',
                  style: GoogleFonts.brawler(
                    textStyle: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.orangeAccent
                              : Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Text(
                'TOKEN',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(
                    fontSize: 20,
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.orangeAccent
                            : Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Textfield(controller: token),

              SizedBox(height: 20),
              Text(
                'EMAIL',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(
                    fontSize: 20,
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.orangeAccent
                            : Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Textfield(controller: email),

              SizedBox(height: 20),
              Text(
                'Password',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(
                    fontSize: 20,
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.orangeAccent
                            : Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Textfield(controller: password),

              SizedBox(height: 20),
              Text(
                'PASSWORD CONFIRMATION',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(
                    fontSize: 20,
                    color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.orangeAccent
                            : Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Textfield(controller: passwordConfirmation),

              SizedBox(height: 20),
              Align(
                alignment: Alignment.topRight,
                child: Button(
                  text: 'Reset Password',
                  onPressed: () {
                    ResetPasswordModel resetPasswordData = ResetPasswordModel(
                      token: token.text.trim(),
                      email: email.text.trim(),
                      password: password.text.trim(),
                      passwordConfirmation: passwordConfirmation.text.trim(),
                    );

                    Token(resetPasswordData, context);
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
