import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lost_and_found/create_Ad/create_ad_reg.dart';
import 'package:lost_and_found/create_Ad/requestor_info.dart';
import 'package:lost_and_found/create_Ad/select_pic.dart';
import 'package:lost_and_found/create_Ad/upload_image.dart';
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
    ),
    GoRoute(
        path: '/requestor_info',
        builder: (BuildContext context, GoRouterState state){
          return requestor_info();
        }
    ),
    GoRoute(
        path: '/upload_image',
        builder: (BuildContext context, GoRouterState state){
          return upload_image();
        }
    ),
    GoRoute(
        path: '/create_add',
        builder: (BuildContext context, GoRouterState state){
          return create_ad_reg();
        }
    ),
    GoRoute(
        path: '/select_pic',
        builder: (BuildContext context, GoRouterState state){
          return select_pic();
        }
    ),
    GoRoute(
        path: '/lost_found',
        builder: (BuildContext context, GoRouterState state){
          return lost_found_items();
        }
    ),

  ],
);
