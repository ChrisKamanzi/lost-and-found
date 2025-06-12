import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_and_found/generated/app_localizations.dart';
import 'package:lost_and_found/widgets/text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../stateManagment/provider/reset_provider.dart';
import '../../widgets/elevated_button.dart';

class forgotPassword extends ConsumerStatefulWidget {
  const forgotPassword({super.key});

  @override
  ConsumerState<forgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<forgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(resetProvider.notifier);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20),
                child: Text(
                  AppLocalizations.of(context)!.forgotPassword,
                  style: GoogleFonts.brawler(
                    textStyle: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).brightness == Brightness.dark
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
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.orangeAccent
                        : Colors.blueGrey,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Textfield(
                controller: emailController,
                hintText: 'Enter your email',
                onChanged: notifier.updateEmail,
                isRequired: true,
              ),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.topRight,
                child: Button(
                  text: AppLocalizations.of(context)!.resetPassword,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      notifier.resetPassword(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Email Required')),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
