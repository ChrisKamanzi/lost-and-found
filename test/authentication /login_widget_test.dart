import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_and_found/pages/authentication/login.dart';
import 'package:lost_and_found/providers/login_loading.dart';

void main() {
  testWidgets('Login form validation and submission', (
    WidgetTester tester,
  ) async {
    final container = ProviderContainer(
      overrides: [loginLoadingProvider.overrideWith((ref) => false)],
    );
    await tester.pumpWidget(
      ProviderScope(parent: container, child: const MaterialApp(home: Login())),
    );
    final emailField = find.byType(TextField).first;
    final passwordField = find.byType(TextFormField);
    final loginButton = find.text('Log In');
    await tester.enterText(emailField, 'chris@gmail.com');
    await tester.enterText(passwordField, 'password123');

    await tester.tap(loginButton);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
