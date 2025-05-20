import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/constant/api.dart';
import 'package:lost_and_found/models/SignUpModel.dart';
import 'package:lost_and_found/widgets/elevated_button.dart';
import 'package:lost_and_found/widgets/text_field.dart';
import '../../providers/VillagesNotifier.dart';
import '../../widgets/PassworldTextfield.dart';

class sign_up extends ConsumerStatefulWidget {
sign_up({super.key});

  @override
  ConsumerState<sign_up> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<sign_up> {
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

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
           SizedBox(height: 100),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Sign Up.',
                style: GoogleFonts.brawler(
                  fontSize: 50,
                  fontWeight: FontWeight.w800,
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.orangeAccent
                          : Colors.black,
                ),
              ),
            ),
            SizedBox(height: 30),
            _buildLabel('NAME'),
            textfield(controller: nameController),
            SizedBox(height: 30),
            _buildLabel('EMAIL'),
            textfield(controller: emailController),
          SizedBox(height: 30),
            _buildLabel('PASSWORD'),
            PasswordField(controller: passController),
           SizedBox(height: 30),
            _buildLabel('PASSWORD CONFIRMATION'),
            PasswordField(controller: passConfController),
             SizedBox(height: 30),
            _buildLabel('PHONE'),
            textfield(controller: phoneController),
         SizedBox(height: 30),
            _buildLabel('VILLAGE'),
            DropdownButtonFormField<String>(
              value: selectedVillage,
              decoration:  InputDecoration(
                labelText: "Select a Village",
                border: OutlineInputBorder(),
              ),
              items:
                  villages
                      .map(
                        (village) => DropdownMenuItem(
                          value: village['id'].toString(),
                          child: Text(village['name']),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                ref.read(selectedVillageProvider.notifier).state = value;
              },
            ),
             SizedBox(height: 40),
            button(
              text: 'Sign Up',
              onPressed: () {
                final selectedVillageId = ref.read(selectedVillageProvider);
                print("Selected village ID: $selectedVillageId");

                final signUpData = SignUpModel(
                  name: nameController.text.trim(),
                  email: emailController.text.trim(),
                  password: passController.text.trim(),
                  passwordConfirmation: passConfController.text.trim(),
                  phone: phoneController.text.trim(),
                  village: selectedVillageId,
                );

                if (_validateInputs(signUpData, context)) {
                  _signUp(signUpData, context);
                }
              },
            ),
            SizedBox(height: 40),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Already have an account?",
                  style: GoogleFonts.brawler(
                    textStyle: TextStyle(
                      fontSize: 15,
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors
                                  .orangeAccent
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
                                ? Colors
                                    .orangeAccent
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

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: GoogleFonts.brawler(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color:
              Theme.of(context).brightness == Brightness.dark
                  ? Colors
                      .orangeAccent
                  : Colors.black,
        ),
      ),
    );
  }

  bool _validateInputs(SignUpModel data, BuildContext context) {
    if (data.name.isEmpty ||
        data.email.isEmpty ||
        data.password.isEmpty ||
        data.passwordConfirmation.isEmpty ||
        data.phone.isEmpty ||
        data.village == null) {
      ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Please fill in all fields.')),
      );
      return false;
    }

    if (data.password != data.passwordConfirmation) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Passwords do not match.')));
      return false;
    }

    return true;
  }

  Future<void> _signUp(SignUpModel signUpData, BuildContext context) async {
    final registerUrl = "$apiUrl/register";

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>  Center(child: CircularProgressIndicator()),
    );

    try {
      final response = await Dio().post(
        registerUrl,
        data: signUpData.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          followRedirects: false,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      Navigator.of(context).pop();

      if (response.statusCode == 200 || response.statusCode == 201) {
        context.go('/congrat');
      } else if (response.statusCode == 422) {
        final errors = response.data['errors'];
        final firstErrorKey = errors.keys.first;
        final firstErrorMsg = errors[firstErrorKey][0];

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(firstErrorMsg)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusMessage}')),
        );
      }
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Something went wrong: $e')));
    }
  }
}
