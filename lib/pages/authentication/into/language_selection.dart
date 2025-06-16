import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/generated/app_localizations.dart';
import 'package:lost_and_found/widgets/elevated_button.dart';
import '../../../stateManagment/provider/locale_provider.dart';

class LanguageSelectionScreen extends ConsumerWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);

    Widget buildLanguageOption({
      required String imagePath,
      required Locale locale,
      required String label,
    }) {
      final isSelected = currentLocale == locale;

      return Column(
        children: [
          GestureDetector(
            onTap: () {
              ref.read(localeProvider.notifier).setLocale(locale);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.transparent,
                  width: 3,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  imagePath,
                  package: 'country_icons',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            label,
            style: GoogleFonts.brawler(
              textStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 200, left: 30, right: 30),
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
                buildLanguageOption(
                  imagePath: 'icons/flags/png/us.png',
                  locale: Locale('en'),
                  label: AppLocalizations.of(context)!.english,
                ),
                SizedBox(width: 40),
                buildLanguageOption(
                  imagePath: 'icons/flags/png/fr.png',
                  locale: Locale('fr'),
                  label: AppLocalizations.of(context)!.french,
                ),
                SizedBox(width: 40),
                buildLanguageOption(
                  imagePath: 'icons/flags/png/rw.png',
                  locale: Locale('rw'),
                  label: AppLocalizations.of(context)!.kinyarwanda,
                ),
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
