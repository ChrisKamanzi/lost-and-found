import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/generated/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lost_and_found/widgets/text_field.dart';
import 'package:lost_and_found/widgets/elevated_button.dart';
import '../../providers/login_loading.dart';
import '../../providers/login_provider.dart';

class Login extends ConsumerWidget {
  Login({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isLoading = ref.watch(loginLoadingProvider);
    final loginNotifier = ref.watch(loginProvider.notifier);

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100),
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.loginTitle,
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
                SizedBox(height: 50),
                Text(
                  AppLocalizations.of(context)!.emailLabel,
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
                SizedBox(height: 10),
                Textfield(controller: emailController),
                SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.passwordLabel,
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
                SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
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
                      AppLocalizations.of(context)!.forgotPassword,
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
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.topRight,
                  child: Button(
                    text: AppLocalizations.of(context)!.loginButton,
                    onPressed: () async {
                      if (!isLoading) {
                        final email = emailController.text.trim();
                        final password = passwordController.text.trim();
                        await loginNotifier.login(email, password);
                        context.go('/homepage');
                      }
                    },
                  ),
                ),

                SizedBox(height: 100),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.noAccount,
                        style: GoogleFonts.brawler(
                          textStyle: TextStyle(
                            fontSize: 15,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.orangeAccent
                                    : Colors.black,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.go('/signUp'),
                        child: Text(
                          AppLocalizations.of(context)!.signUp,
                          style: GoogleFonts.brawler(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.orangeAccent
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
              child: Center(
                child: CircularProgressIndicator(color: Colors.deepPurple),
              ),
            ),
        ],
      ),
    );
  }
}
