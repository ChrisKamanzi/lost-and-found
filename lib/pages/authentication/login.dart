import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lost_and_found/constant/api.dart';
import 'package:lost_and_found/widgets/text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/elevated_button.dart';
import 'package:http/http.dart' as http;

class login extends StatelessWidget {
  const login({super.key});

  Future<void> _login(
      String email,
      String password,
      BuildContext context,
      ) async {
    String loginUrl = "$apiUrl/login";
    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        body: {'email': email, 'password': password},
      );

      print('Response body: ${response.body}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        final token = data['token'];
        final int userId = data['user']['id'];

        if (token != null && userId != null) {
          await saveToken(token, userId);
          print('Success: $data');
          print("id is = $userId and token is $token");
          context.go('/homepage');
        } else {
          print('Token or User ID missing in response');
          print("id is = $userId and token is $token");
        }
      } else {
        print('Login failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> saveToken(String token, int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
    await prefs.setInt('userId', userId);
    print('Token saved: $token');
    print('User ID saved: $userId');
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _email = TextEditingController();
    TextEditingController _password = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
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
              SizedBox(height: 10),
              textfield(controller: _email),
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
                controller: _password,
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
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => context.push('/forrgotPassword'),
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
                child: button(
                  text: 'Log In',
                  onPressed: () {
                    _login(_email.text, _password.text, context);
                  },
                ),
              ),
              SizedBox(height: 60),
              TextButton(
                onPressed: () => context.push('/chat'),
                child: Text('Temporary Button'),
              ),

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
                    TextButton(
                      onPressed: () => context.go('/signUp'),
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.brawler(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                        ),
                      ),
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
