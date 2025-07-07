import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lost_and_found/stateManagment/Notifier/user_notifier.dart';
import '../../../stateManagment/Notifier/splash_notifier.dart';
import '../../certificate.dart';
import '../../services/certificate_pinning.dart';
import '../../services/root_detection.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isInTest = Platform.environment.containsKey('FLUTTER_TEST');

    if (!isInTest) {
      Future.microtask(() async {
        if (Platform.isAndroid || Platform.isIOS) {
          final isPinned =
              await CertificatePinning.checkServerCertificate(
                serverURL: apiUrl,
                allowedFingerprints: [CERTIFICATE],
              );
          final compromised = await DeviceSecurity.isDeviceCompromised();
          if (compromised || !isPinned) {
            context.go('/alert');
            return;
          } else if (isPinned && !compromised) {
            context.go('/login');
          }
        }
        final next = ref.read(splashProvider);
        if (next != null) {
          context.go(next);
        }
      });
    }
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
