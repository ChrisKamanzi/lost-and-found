import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lost_and_found/constant/api.dart';
import 'package:lost_and_found/widgets/text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/elevated_button.dart';
import 'package:http/http.dart' as http;

class forgotPassword extends StatelessWidget {
  const forgotPassword({super.key});

  Future<void> _forgotPassword(String email, BuildContext context) async {
    String login = "$apiUrl/forgot-password";
    try {
      final response = await http.post(
        Uri.parse(login),
        body: {'email': email},
      );

      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Success: $data');
        context.go('/token');
      } else {
        print('Forgot password failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _email = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20),
              child: Text(
                'Forgot Password',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Text(
              'Email',
              style: GoogleFonts.brawler(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 30),
            textfield(controller: _email),

            SizedBox(height: 40),
            Align(
              alignment: Alignment.topRight,
              child: button(
                text: 'Reset Password',
                onPressed: () {
                  _forgotPassword(_email.text, context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
