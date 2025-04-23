import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lost_and_found/pages/authentication/congrat.dart';
import 'package:lost_and_found/pages/authentication/forgot_password.dart';
import 'package:lost_and_found/pages/authentication/forgot_token.dart';
import 'package:lost_and_found/pages/authentication/home_login%20.dart';
import 'package:lost_and_found/pages/authentication/into/report.dart';
import 'package:lost_and_found/pages/authentication/into/splash_screen.dart';
import 'package:lost_and_found/pages/authentication/login.dart';
import 'package:lost_and_found/pages/authentication/sign_up.dart';
import 'package:lost_and_found/pages/home/lost&found/acount.dart';
import 'package:lost_and_found/pages/home/lost&found/card_detail.dart';
import 'package:lost_and_found/pages/home/home.dart';
import 'package:lost_and_found/pages/home/lost&found/lost_found_items.dart';
import 'package:lost_and_found/pages/home/lost&found/message.dart';
import 'package:lost_and_found/pages/searchOnMap/map.dart';
import 'package:lost_and_found/providers/themNotifier.dart';
import 'create_Ad/create_ad_reg.dart';
import 'create_Ad/requestor_info.dart';
import 'create_Ad/select_pic.dart';
import 'create_Ad/upload_image.dart';

void main() {
  runApp( ProviderScope(child: MyApp()));
}
class MyApp extends ConsumerWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);

    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
    );
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
        return home_login();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return login();
      },
    ),
    GoRoute(
      path: '/signUp',
      builder: (BuildContext context, GoRouterState state) {
        return sign_up();
      },
    ),

    GoRoute(
      path: '/homepage',
      builder: (BuildContext context, GoRouterState state) {
        return homepage();
      },
    ),
    GoRoute(
      path: '/allItems',
      builder: (BuildContext context, GoRouterState state) {
        return lostFoundItems();
      },
    ),
    GoRoute(
      path: '/requestor_info',
      builder: (BuildContext context, GoRouterState state) {
        return requestor_info();
      },
    ),
    GoRoute(
      path: '/upload_image',
      builder: (BuildContext context, GoRouterState state) {
        return uploadImage();
      },
    ),
    GoRoute(
      path: '/create_add',
      builder: (BuildContext context, GoRouterState state) {
        return CreateAdReg();
      },
    ),
    GoRoute(
      path: '/select_pic',
      builder: (BuildContext context, GoRouterState state) {
        return select_pic();
      },
    ),
    GoRoute(
      path: '/lost_found',
      builder: (BuildContext context, GoRouterState state) {
        return lostFoundItems();
      },
    ),
    GoRoute(
      path: '/forrgotPassword',
      builder: (BuildContext context, GoRouterState state) {
        return forgotPassword();
      },
    ),
    GoRoute(
      path: '/token',
      builder: (BuildContext context, GoRouterState state) {
        return TokenPage();
      },
    ),
    GoRoute(
      path: '/account',
      builder: (BuildContext context, GoRouterState state) {
        return account();
      },
    ),
    GoRoute(
      path: '/congrat',
      builder: (BuildContext context, GoRouterState state) {
        return congrat();
      },
    ),
    GoRoute(
      path: '/report',
      builder: (BuildContext context, GoRouterState state) {
        return report();
      },
    ),
    GoRoute(
      path: '/cardDetail',
      builder: (BuildContext context, GoRouterState state) {
        return cardDetail();
      },
    ),
    GoRoute(
      path: '/map',
      builder: (BuildContext context, GoRouterState state) {
        return map();
      },
    ),
    GoRoute(
      path: '/chat',
      builder: (BuildContext context, GoRouterState state) {
        return chat();
      },
    ),
  ],
);}

