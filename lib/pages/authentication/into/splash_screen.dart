import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../stateManagment/Notifier/splash_notifier.dart';
import '../../services/caertificate_pinning.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // One-time trigger to run cert check when the widget is first built
    Future.microtask(() async {
      if (Platform.isAndroid || Platform.isIOS) {
        await CertificatePinningService.checkServerCertificate();
      }
    });

    // Navigation logic
    ref.listen<String?>(splashProvider, (prev, next) {
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
