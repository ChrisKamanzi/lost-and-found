import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:lost_and_found/widgets/elevated_button.dart';

class congrat extends StatelessWidget {
   congrat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'asset/animation.json',
                  width: 250,
                  repeat: true,
                  animate: true,
                ),
                SizedBox(height: 20),
                Text(
                  'Congrats!',
                  style: GoogleFonts.brawler(
                    textStyle:  TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
             SizedBox(height: 16),
                Text(
                  'Your sign-up is complete 🎉',
                  style: GoogleFonts.brawler(
                    textStyle:TextStyle(
                      fontSize: 22,
                      color: Colors.white70,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
            SizedBox(height: 80),
                Button(
                  text: 'CONTINUE',
                  onPressed: () => context.go('/login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
