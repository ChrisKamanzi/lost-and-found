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
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: GestureDetector(
                        onTap:
                            () => ref
                                .read(localeProvider.notifier)
                                .setLocale(Locale('en')),
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
                    SizedBox(height: 10),

                    Text(
                      AppLocalizations.of(context)!.english,
                      style: GoogleFonts.brawler(
                        textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 40),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
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
                    SizedBox(height: 10),
                    Text(
                      AppLocalizations.of(context)!.french,
                      style: GoogleFonts.brawler(
                        textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 40),
                Column(
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
                                .setLocale(const Locale('rw')),
                        child: ClipOval(
                          child: Image.asset(
                            'icons/flags/png/rw.png',
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
                      AppLocalizations.of(context)!.kinyarwanda,
                      style: GoogleFonts.brawler(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
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
