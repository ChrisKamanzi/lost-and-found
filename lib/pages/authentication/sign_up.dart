import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/widgets/text_field.dart';
import '../../constant/api.dart';
import '../../widgets/elevated_button.dart';
import 'package:http/http.dart' as http;

class sign_up extends StatelessWidget {
  const sign_up({super.key});

  Future<void> _signUp(
    String name,
    String email,
    String password,
    String passwordConf,
    String phone,
    BuildContext context,
  ) async {
    String login = "$apiUrl/register";

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      },
    );
    try {
      final response = await http.post(
        Uri.parse(login),
        body: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConf,
          'phone_number': phone,
        },
      );
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        Navigator.of(context).pop();
        final data = json.decode(response.body);
        print('Success: $data');
        context.go('/congrat');
      } else {
        Navigator.of(context).pop();
        print('Login failed with status: ${response.statusCode}');
      }
    } catch (e) {
      Navigator.of(context).pop();
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _name = TextEditingController();
    TextEditingController _email = TextEditingController();
    TextEditingController _phone = TextEditingController();
    TextEditingController _pass = TextEditingController();
    TextEditingController _passConf = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
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
              SizedBox(height: 30),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'NAME',
                  style: GoogleFonts.brawler(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              textfield(controller: _name),
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
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              textfield(controller: _email),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'PASSWORD',
                  style: GoogleFonts.brawler(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: _pass,
                obscureText: true,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 12,
                  ),

                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.remove_red_eye),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'PASSWORD CONFIRMATION',
                  style: GoogleFonts.brawler(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              TextFormField(
                controller: _passConf,
                obscureText: true,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 12,
                  ),

                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.remove_red_eye),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'PHONE',
                  style: GoogleFonts.brawler(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              textfield(controller: _phone),
              SizedBox(height: 30),
              button(
                text: 'Sign Up',
                onPressed: () {
                  String phone = _phone.text.trim();
                  _signUp(
                    _name.text,
                    _email.text,
                    _pass.text,
                    _passConf.text,
                    phone,
                    context,
                  );
                },
              ),
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
                    TextButton(
                      onPressed: () {
                        context.go('/login');
                      },
                      child: Text('Sign In'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
