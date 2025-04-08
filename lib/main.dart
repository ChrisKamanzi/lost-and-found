import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lost_and_found/pages/authentication/home_login .dart';
import 'package:lost_and_found/pages/authentication/login.dart';
import 'package:lost_and_found/pages/authentication/sign_up.dart';
import 'package:lost_and_found/pages/home/all_card.dart';
import 'package:lost_and_found/pages/home/home.dart';
import 'package:lost_and_found/pages/home/lost_found_items.dart';
import 'package:lost_and_found/pages/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
     // child:  splash_Screen(),
    );
  }
}
final GoRouter _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (BuildContext context, GoRouterState state) {
        return splash_Screen();
      },
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return home_login ();
      }
    ),
    GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return login();
        }
    ),
    GoRoute(
      path: '/signUp',
      builder: (BuildContext context, GoRouterState state){
        return sign_up();
      }
    ),
    GoRoute(
      path: '/allcards',
      builder: (BuildContext context, GoRouterState state){
        return all_cards();
      }
    ),
    GoRoute(
      path: '/homepage',
      builder: (BuildContext context, GoRouterState state) {
        return homepage();
      },
    ),
    GoRoute(
      path: '/allItems',
      builder: (BuildContext context, GoRouterState state){
        return lost_found_items ();
      }
    )
  ],
);
