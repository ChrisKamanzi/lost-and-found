import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/elevated_button.dart';

class home_login extends StatefulWidget {
  const home_login ({super.key});

  @override
  State<home_login > createState() => _HomepageState();
}

class _HomepageState extends State<home_login > {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('asset/logo.png', width: 100, height: 100),
            SizedBox(height: 20),
            Text(
              'Find Lost',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: button(
                text: 'Log In',
                onPressed: () => context.go('/login'),
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: button(text: 'Sign Up', onPressed: ()=> context.go('/signUp')),
            ),
          ],
        ),
      ),
    );
  }
}
