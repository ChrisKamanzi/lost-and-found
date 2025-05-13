import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lost_and_found/widgets/text_field.dart';
import 'package:lost_and_found/widgets/elevated_button.dart';
import '../../providers/login_loading.dart';
import '../../providers/loginProvider.dart';

class login extends ConsumerWidget {
  const login({super.key});

  Future<void> _login(
    WidgetRef ref,
    String email,
    String password,
    BuildContext context,
  ) async {
    ref.read(loginLoadingProvider.notifier).state = true;

    try {
      await ref.read(loginProvider.notifier).login(email, password);
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');
      final userId = prefs.getInt('userId');

      if (token != null && userId != null) {
        print('${token}');
        context.go('/homepage');
      } else {
        print('Login successful but token/userId not found in storage.');
      }
    } catch (e) {
      print('Login exception: $e');
    } finally {
      ref.read(loginLoadingProvider.notifier).state = false;
    }
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
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.orangeAccent
                                : Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Text(
                  'Email',
                  style: GoogleFonts.brawler(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors
                                  .orangeAccent
                              : Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                textfield(controller: _email),
                const SizedBox(height: 10),
                Text(
                  'Password',
                  style: GoogleFonts.brawler(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors
                                  .orangeAccent
                              : Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _password,
                  obscureText: true,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    suffixIcon: const Icon(Icons.remove_red_eye),
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
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          color:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.orange.shade700
                                  : Colors.blueGrey,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
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

                const SizedBox(height: 100),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: GoogleFonts.brawler(
                          textStyle: TextStyle(
                            fontSize: 15,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors
                                        .orangeAccent
                                    : Colors.black,
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
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors
                                          .orangeAccent
                                      : Colors.black,
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
              child: const Center(
                child: CircularProgressIndicator(color: Colors.deepPurple),
              ),
            ),
        ],
      ),
    );
  }
}
