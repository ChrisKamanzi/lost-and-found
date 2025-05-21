import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lost_and_found/constant/api.dart';
import 'package:lost_and_found/providers/reset_password_notifier.dart';
import 'package:lost_and_found/widgets/text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/reset_password.dart';
import '../../widgets/elevated_button.dart';

class TokenPage extends ConsumerWidget {
  const TokenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController token = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController passwordConfirmation = TextEditingController();

    final notifier = ref.watch(resetProvider.notifier);

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
              Textfield(controller: token, onChanged: notifier.updateToken),

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
              Textfield(controller: email, onChanged: notifier.updateEmail),

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
              Textfield(
                controller: password,
                onChanged: notifier.updatePassword,
              ),

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
              Textfield(
                controller: passwordConfirmation,
                onChanged: notifier.updatePasswordConfirmation,
              ),

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

                    notifier.resetPassword(context);
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
