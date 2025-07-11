import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Add this import
import 'package:lost_and_found/generated/app_localizations.dart';
import 'package:lost_and_found/pages/certificate.dart';
import 'dart:io';
import 'package:lost_and_found/pages/services/certificate_pinning.dart';
import 'package:lost_and_found/pages/services/root_detection.dart';
import '../../stateManagment/Notifier/user_notifier.dart';
import '../../stateManagment/provider/locale_provider.dart';

class SecurityAlertPage extends ConsumerWidget {
  SecurityAlertPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        backgroundColor: Colors.orange.shade700,
        title: Center(
          child: Text(
            AppLocalizations.of(context)!.security,
            style: GoogleFonts.brawler(
              fontWeight: FontWeight.w800,
              fontSize: 30,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLanguageOption(
                    context,
                    ref,
                    'en',
                    'us',
                    AppLocalizations.of(context)!.english,
                  ),
                  SizedBox(width: 20),
                  _buildLanguageOption(
                    context,
                    ref,
                    'fr',
                    'fr',
                    AppLocalizations.of(context)!.french,
                  ),
                  SizedBox(width: 20),
                  _buildLanguageOption(
                    context,
                    ref,
                    'rw',
                    'rw',
                    AppLocalizations.of(context)!.kinyarwanda,
                  ),
                ],
              ),
              SizedBox(height: 30),
        
              Icon(
                Icons.warning_rounded,
                size: 80,
                color: Colors.orange.shade700,
              ),
              SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.security_alert_detected,
                style: GoogleFonts.brawler(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.security_alert_message,
                style: GoogleFonts.brawler(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
        
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade700,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () async {
                  final isSecure = await CertificatePinning.checkServerCertificate(
                    serverURL: apiUrl,
                    allowedFingerprints: [CERTIFICATE],
                    timeout: 50,
                  );
        
                  final compromised = await DeviceSecurity.isDeviceCompromised();
                  if (isSecure != true  && compromised != true){
        
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppLocalizations.of(context)!.alert_message,
                          style: GoogleFonts.brawler(fontSize: 16),
                        ),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                },
                icon: Icon(Icons.refresh),
                label: Text(
                  AppLocalizations.of(context)!.retry_connection,
                  style: GoogleFonts.brawler(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextButton.icon(
                onPressed: () => exit(0),
                icon: Icon(Icons.exit_to_app, color: Colors.black),
                label: Text(
                  AppLocalizations.of(context)!.exit_app,
                  style: GoogleFonts.brawler(color: Colors.black, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    WidgetRef ref,
    String localeCode,
    String flagCode,
    String label,
  ) {
    return Column(
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
                    .setLocale(Locale(localeCode)),
            child: ClipOval(
              child: Image.asset(
                'icons/flags/png/$flagCode.png',
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
}
