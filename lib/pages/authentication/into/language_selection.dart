import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/generated/app_localizations.dart';
import 'package:lost_and_found/widgets/elevated_button.dart';
import '../../../providers/localeNotifier.dart';

class LanguageSelectionScreen extends ConsumerWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 200, left: 30, right: 30),
        child: Column(
          children: [
            Image.asset('asset/logo.png', height: 130, width: 130),

            SizedBox(height: 50),

            Text(
              AppLocalizations.of(context)!.chooseLanguage,
              style: GoogleFonts.brawler(
                textStyle: TextStyle(
                  fontSize: 40,
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            SizedBox(height: 20),

            Text(
              AppLocalizations.of(context)!.whatLanguage,
              style: GoogleFonts.brawler(
                textStyle: TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
            ),

            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: GestureDetector(
                    onTap:
                        () => ref
                            .read(localeProvider.notifier)
                            .setLocale(const Locale('en')),
                    child: ClipOval(
                      child: Image.asset(
                        'icons/flags/png/us.png',
                        package: 'country_icons',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 40),

                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: GestureDetector(
                    onTap:
                        () => ref
                            .read(localeProvider.notifier)
                            .setLocale(Locale('fr')),
                    child: ClipOval(
                      child: Image.asset(
                        'icons/flags/png/fr.png',
                        package: 'country_icons',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 40),
              ],
            ),
            SizedBox(height: 50),
            Button(
              text: AppLocalizations.of(context)!.next,
              onPressed: () => context.go('/report'),
            ),
          ],
        ),
      ),
    );
  }
}
