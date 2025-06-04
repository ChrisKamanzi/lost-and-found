import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_and_found/generated/app_localizations.dart';
import 'package:lost_and_found/widgets/text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../stateManagment/provider/reset_provider.dart';
import '../../widgets/elevated_button.dart';

class forgotPassword extends ConsumerWidget {
  const forgotPassword({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(resetProvider.notifier);

    TextEditingController email = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10, left: 20),
              child: Text(
                AppLocalizations.of(context)!.forgotPassword,
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(
                    fontSize: 30,
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
                          : Colors.blueGrey,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 30),
            Textfield(controller: email, onChanged: notifier.updateEmail),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.topRight,
              child: Button(
                text: AppLocalizations.of(context)!.resetPassword,
                onPressed: () => notifier.resetPassword(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
