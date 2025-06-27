import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lost_and_found/Certificate.dart';
import 'package:lost_and_found/stateManagment/Notifier/user_notifier.dart';
import '../../../stateManagment/Notifier/splash_notifier.dart';
import '../../services/certificate_pinning.dart';
import '../../services/root_detection.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.microtask(() async {
      if (Platform.isAndroid || Platform.isIOS) {
        final pinn = await CertificatePinningService.checkServerCertificate(
          serverURL: apiUrl,
          allowedFingerprints: [CERTIFICATE],
        );

        final compromised = await DeviceSecurityService.isDeviceCompromised(
          context,
        );
        if (compromised || !pinn) {
          context.go('/alert');
          return;
        } else if (pinn && !compromised) {
          context.go('/login');
        }
      }
      final next = ref.read(splashProvider);
      if (next != null) {
        context.go(next);
      }
    });

    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image(
          image: AssetImage('asset/logo.png'),
          height: 150,
          width: 150,
        ),
      ),
    );
  }
}
