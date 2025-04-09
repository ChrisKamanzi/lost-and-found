import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lost_and_found/widgets/text_field.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/elevated_button.dart';

class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _email = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100, left: 70),
              child: Text(
                'Log In.',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),)
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
            SizedBox(height: 10),
            textfield(controller: _email,),
            SizedBox(height: 10),
            Text(
              'Password',
              style: GoogleFonts.brawler(
                textStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 10),
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
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot Password',
                  style: GoogleFonts.brawler(
                    textStyle: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),

            SizedBox(height: 30),
            Align(
              alignment: Alignment.topRight,
              child: button(text: 'Log In', onPressed: ()=> context.go('/homepage')),
            ),
            SizedBox(height: 60),

            Align(
              alignment: Alignment.center,
              child: Text(
                'OR SIGN IN WITH',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 70, top: 150),
              child: Row(
                children: [
                  Text(
                    'Dont have an account?',
                    style: GoogleFonts.brawler(
                      textStyle: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                  TextButton(onPressed: () =>context.go('/signUp'),
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.brawler(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 15
                          )
                        ),
                      )
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
