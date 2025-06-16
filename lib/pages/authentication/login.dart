import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/generated/app_localizations.dart';
import 'package:lost_and_found/widgets/text_field.dart';
import '../../stateManagment/provider/loading_provider.dart';
import '../../stateManagment/provider/login_provider.dart';
import '../services/deviceManager.dart';

class Login extends ConsumerWidget {
  Login({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loginLoadingProvider);

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
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
                  const SizedBox(height: 50),
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
                  const SizedBox(height: 10),
                  Textfield(controller: emailController, isRequired: true),
                  const SizedBox(height: 10),
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
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? AppLocalizations.of(context)!.enter_password
                                : null,
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
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.topRight,
                    child: Consumer(
                      builder: (context, ref, _) {
                        final loginState = ref.watch(loginProvider);
                        final loginNotifier = ref.read(loginProvider.notifier);

                        return SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange.shade600,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 40,
                                vertical: 15,
                              ),
                            ),
                            onPressed:
                                loginState.isLoading
                                    ? null
                                    : () async {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        final email =
                                            emailController.text.trim();
                                        final password =
                                            passwordController.text.trim();

                                        final deviceId = await  Devicemanager.getDeviceId();
                                        print('📱 Logged-in device ID: $deviceId');

                                        await loginNotifier.login(
                                          email,
                                          password,
                                        );
                                        final state = ref.read(loginProvider);
                                        state.when(
                                          data: (_) => context.go('/homepage'),
                                          error: (err, _) {
                                            showDialog(
                                              context: context,
                                              builder:
                                                  (_) => AlertDialog(
                                                    title:  Text(
                                                      AppLocalizations.of(context)!.login_failed,
                                                    ),
                                                    content: Text(
                                                      err.toString(),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed:
                                                            () => context.pop(),
                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  ),
                                            );
                                          },
                                          loading: () {}, // no-op
                                        );
                                      }
                                    },
                            child:
                                loginState.isLoading
                                    ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                    : Text(
                                      AppLocalizations.of(context)!.loginButton,
                                      style: GoogleFonts.brawler(
                                        textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 100),
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
                                  Theme.of(context).brightness ==
                                          Brightness.dark
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
