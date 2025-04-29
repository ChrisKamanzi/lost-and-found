import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/constant/api.dart';
import 'package:lost_and_found/models/SignUpModel.dart';
import 'package:lost_and_found/widgets/elevated_button.dart';
import 'package:lost_and_found/widgets/text_field.dart';
import '../../providers/districtsNotifier.dart';

class sign_up extends ConsumerWidget {
  const sign_up({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final villages = ref.watch(villageProvider);
    final selectedVillage = ref.watch(selectedVillageProvider);

    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final passController = TextEditingController();
    final passConfController = TextEditingController();

    if (villages.isEmpty) {
      ref.read(villageProvider.notifier).fetchVillages();
    }

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
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildLabel('NAME'),
            textfield(controller: nameController),
            const SizedBox(height: 30),
            _buildLabel('EMAIL'),
            textfield(controller: emailController),
            const SizedBox(height: 30),
            _buildLabel('PASSWORD'),
            _passwordField(passController),
            const SizedBox(height: 30),
            _buildLabel('PASSWORD CONFIRMATION'),
            _passwordField(passConfController),
            const SizedBox(height: 30),
            _buildLabel('PHONE'),



            textfield(controller: phoneController),
            const SizedBox(height: 30),
            _buildLabel('VILLAGE'),
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
                }

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
        style: GoogleFonts.brawler(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _passwordField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade200,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 12,
        ),
        suffixIcon: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.remove_red_eye),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
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
        const SnackBar(content: Text('Please fill in all fields.')),
      );
      return false;
    }

    if (data.password != data.passwordConfirmation) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match.')),
      );
      return false;
    }

    return true;
  }

  Future<void> _signUp(SignUpModel signUpData, BuildContext context) async {
    final registerUrl = "$apiUrl/register";

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
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

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(firstErrorMsg)),
        );
      } else {
        print('👀${response.statusMessage}');
        ScaffoldMessenger.of(context).showSnackBar(
          
          SnackBar(content: Text('Error: ${response.statusMessage}')),
        );
      }
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong: $e')),
      );
    }
  }
}
