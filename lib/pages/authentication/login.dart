import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lost_and_found/constant/api.dart';
import 'package:lost_and_found/widgets/text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/login_model.dart';
import '../../providers/login_loading.dart';
import '../../widgets/elevated_button.dart';
import 'package:dio/dio.dart';

class login extends ConsumerWidget {
  const login({super.key});

  Future<void> _login(
    WidgetRef ref,
    String email,
    String password,
    BuildContext context,
  ) async {
    ref.read(loginLoadingProvider.notifier).state = true;

    LoginModel loginData = LoginModel(email: email, password: password);
    String loginUrl = "$apiUrl/login";
    Dio dio = Dio();

    try {
      final response = await dio.post(
        loginUrl,
        data: loginData.toMap(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          followRedirects: false,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        final token = data['token'];
        final int? userId = data['user']?['id'];

        if (token != null && userId != null) {
          await saveToken(token, userId);
          context.go('/homepage');
        }
      } else {
        print('Login failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      ref.read(loginLoadingProvider.notifier).state = false; // 👈 Stop loading
    }
  }

  Future<void> saveToken(String token, int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
    await prefs.setInt('userId', userId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loginLoadingProvider);

    final TextEditingController _email = TextEditingController();
    final TextEditingController _password = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100),
                Center(
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
                    suffixIcon: Icon(Icons.remove_red_eye),
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
                      if (!isLoading) {
                        _login(ref, _email.text, _password.text, context);
                      }
                    },
                  ),
                ),
                SizedBox(height: 60),
                Center(
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
                SizedBox(height: 100),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: GoogleFonts.brawler(
                          textStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
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

          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: Center(
                child: CircularProgressIndicator(color: Colors.deepPurple),
              ),
            ),
        ],
      ),
    );
  }
}
