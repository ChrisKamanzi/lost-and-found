import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/providers/sign_up_notifier.dart';
import 'package:lost_and_found/widgets/elevated_button.dart';
import 'package:lost_and_found/widgets/text_field.dart';
import '../../providers/villages_notifier.dart';
import '../../widgets/build_label.dart';
import '../../widgets/passworld_textfield.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUp> {

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passController;
  late TextEditingController passConfController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passController = TextEditingController();
    passConfController = TextEditingController();

    Future.microtask(() {
      final villages = ref.read(villageProvider);
      if (villages.isEmpty) {
        ref.read(villageProvider.notifier).fetchVillages();
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passController.dispose();
    passConfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final villages = ref.watch(villageProvider);
    final selectedVillage = ref.watch(selectedVillageProvider);
    final signUpNotifier = ref.read(signUpProvider.notifier);
    final isLoading = ref.watch(loadingProvider);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const SizedBox(height: 100),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Sign Up.',
                style: GoogleFonts.brawler(
                  fontSize: 50,
                  fontWeight: FontWeight.w800,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.orangeAccent
                      : Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 30),
            buildLabel(context, 'NAME'),
            Textfield(controller: nameController),
            const SizedBox(height: 30),
            buildLabel(context, 'EMAIL'),
            Textfield(controller: emailController),
            const SizedBox(height: 30),
            buildLabel(context, 'PASSWORD'),
            PasswordField(controller: passController),
            const SizedBox(height: 30),
            buildLabel(context, 'PASSWORD CONFIRMATION'),
            PasswordField(controller: passConfController),
            const SizedBox(height: 30),
            buildLabel(context, 'PHONE'),
            Textfield(controller: phoneController),
            const SizedBox(height: 30),
            buildLabel(context, 'VILLAGE'),
            DropdownButtonFormField<String>(
              value: selectedVillage,
              decoration: const InputDecoration(
                labelText: "Select a Village",
                border: OutlineInputBorder(),
              ),
              items: villages
                  .map((village) => DropdownMenuItem(
                value: village['id'].toString(),
                child: Text(village['name']),
              ))
                  .toList(),
              onChanged: (value) {
                ref.read(selectedVillageProvider.notifier).state = value;
              },
            ),
            const SizedBox(height: 40),
            isLoading
                ? const CircularProgressIndicator()
                : Button(
              text: 'Sign Up',
              onPressed: () async {
                signUpNotifier.updateField(
                  name: nameController.text,
                  email: emailController.text,
                  password: passController.text,
                  passwordConfirmation: passConfController.text,
                  phone: phoneController.text,
                  village: selectedVillage,
                );

                await signUpNotifier.signUp(context, ref);
              },
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Already have an account?",
                  style: GoogleFonts.brawler(
                    textStyle: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.orangeAccent
                          : Colors.blueGrey,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => context.go('/login'),
                  child: Text(
                    'Login',
                    style: GoogleFonts.brawler(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                        color:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.orangeAccent
                            : Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


}
