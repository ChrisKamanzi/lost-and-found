import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lost_and_found/constant/api.dart';
import 'package:lost_and_found/widgets/text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/elevated_button.dart';

class forgotPassword extends StatelessWidget {
  const forgotPassword({super.key});

  Future<void> _forgotPassword(String email, BuildContext context) async {
    String loginUrl = "$apiUrl/forgot-password";

    Dio dio = Dio();

    try {
      final response = await dio.post(loginUrl, data: {'email': email});
      print('Response body: ${response.data}');
      if (response.statusCode == 200) {
        final data = response.data;
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

    TextEditingController email = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10, left: 20),
              child: Text(
                'Forgot Password',
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
              'Email',
              style: GoogleFonts.brawler(
                textStyle: TextStyle(
                  fontSize: 20,
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.orangeAccent
                          : Colors.blueGrey,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 30),
            Textfield(controller: email),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.topRight,
              child: Button(
                text: 'Reset Password',
                onPressed: () {
                  _forgotPassword(email.text, context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
