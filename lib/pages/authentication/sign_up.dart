import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/widgets/text_field.dart';

import '../../widgets/elevated_button.dart';

class sign_up extends StatelessWidget {
  const sign_up({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100, left: 50),
              child: Text(
                'Sign Up.',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'NAME',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  )
                ),
              ),
            ),
            SizedBox(height: 5),
            textfield(),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'EMAIL',
                style: GoogleFonts.brawler(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    )
                ),
              ),
            ),
            SizedBox(height: 5,),
            textfield(),
            SizedBox(height: 30,),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'PASSWORD',
                style: GoogleFonts.brawler(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    )
                ),
              ),
            ),
            SizedBox(height: 5),
            TextFormField(
              obscureText: true,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),

                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.remove_red_eye),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 30,),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'PHONE',
                style: GoogleFonts.brawler(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    )
                ),
              ),
            ),
            SizedBox(height: 5),
            textfield(),
            SizedBox(height: 30,),
            button(text: 'Sign Up', onPressed: (){}),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 70, top: 100),
              child: Row(
                children: [
                  Text(
                    'Already have an account?',
                    style: GoogleFonts.brawler(
                      textStyle: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                  TextButton(onPressed: () =>context.go('/login'),
                      child: Text('Sign In')
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
