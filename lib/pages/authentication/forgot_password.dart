import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lost_and_found/constant/api.dart';
import 'package:lost_and_found/widgets/text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/reset_password_notifier.dart';
import '../../widgets/elevated_button.dart';

class forgotPassword extends ConsumerWidget {
  const forgotPassword({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(resetProvider.notifier);

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
            Textfield(controller: email, onChanged: notifier.updateEmail),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.topRight,
              child: Button(
                text: 'Reset Password',
                onPressed: () => notifier.resetPassword(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
