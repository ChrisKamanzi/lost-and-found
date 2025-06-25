import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:lost_and_found/pages/services/caertificate_pinning.dart';

class RootAlertPage extends StatelessWidget {
  const RootAlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        backgroundColor: Colors.orange.shade700,
        title: Text(
          'Security Alert',
          style: GoogleFonts.brawler(fontWeight: FontWeight.w500, fontSize: 30),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_rounded,
              size: 80,
              color: Colors.orange.shade700,
            ),
            SizedBox(height: 20),
            Text(
              'Untrusted Connection Detected',
              style: GoogleFonts.brawler(
                textStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'For your safety: We’ve detected that your '
              'device might be compromised or not fully secure. '
              'This could affect your privacy and the app’s performance. '
              'Please ensure your device is genuine and hasn’t been tampered '
              'with before continuing. ',
              style: GoogleFonts.brawler(fontSize: 20),
            ),
            SizedBox(height: 40),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.shade700,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: () async {
                await CertificatePinningService.checkServerCertificate(context);
              },
              icon: Icon(Icons.refresh),
              label: Text(
                "Retry Connection",
                style: GoogleFonts.brawler(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 16),
            TextButton.icon(
              onPressed: () {
                exit(0);
              },
              icon: Icon(Icons.exit_to_app, color: Colors.black),
              label: Text(
                "Exit App",
                style: GoogleFonts.brawler(color: Colors.black, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
