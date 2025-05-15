import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lost_and_found/pages/authentication/congrat.dart';
import 'package:lost_and_found/pages/authentication/forgot_password.dart';
import 'package:lost_and_found/pages/authentication/forgot_token.dart';
import 'package:lost_and_found/pages/authentication/into/About%20us.dart';
import 'package:lost_and_found/pages/authentication/into/report.dart';
import 'package:lost_and_found/pages/authentication/into/splash_screen.dart';
import 'package:lost_and_found/pages/authentication/login.dart';
import 'package:lost_and_found/pages/authentication/sign_up.dart';
import 'package:lost_and_found/pages/create_Ad/create_ad_reg.dart';
import 'package:lost_and_found/pages/home/lost&found/acount.dart';
import 'package:lost_and_found/pages/home/lost&found/card_detail.dart';
import 'package:lost_and_found/pages/home/home.dart';
import 'package:lost_and_found/pages/home/lost&found/favoriteScreen.dart';
import 'package:lost_and_found/pages/home/lost&found/lost_found_items.dart';
import 'package:lost_and_found/pages/message/char2.dart';
import 'package:lost_and_found/pages/message/conversation.dart';
import 'package:lost_and_found/pages/searchOnMap/MapItem.dart';
import 'package:lost_and_found/pages/searchOnMap/map.dart';
import 'package:lost_and_found/providers/themNotifier.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.black,
  textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
);

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);

    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
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
          return LostFoundItemsScreen();
        },
      ),

      GoRoute(
        path: '/create_add',
        builder: (BuildContext context, GoRouterState state) {
          return CreateAdReg();
        },
      ),
      GoRoute(
        path: '/lost_found',
        builder: (BuildContext context, GoRouterState state) {
          return LostFoundItemsScreen();
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
          return Account();
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
        path: '/cardDetail/:itemId',
        builder: (BuildContext context, GoRouterState state) {
          final itemId = state.pathParameters['itemId']!;
          return cardDetail(itemId: itemId);
        },
      ),
      GoRoute(
        path: '/map',
        builder: (BuildContext context, GoRouterState state) {
          return MapScreen();
        },
      ),
      GoRoute(
        path: '/mapItem',
        builder: (BuildContext context, GoRouterState state) {
          return MapItem();
        },
      ),
      GoRoute(
        path: '/favorite',
        builder: (BuildContext context, GoRouterState state) {
          return FavoriteScreen();
        },
      ),
      GoRoute(
        path: '/conversation',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final itemId = extra['itemId'];
          final receiverId = extra['receiverId'];
          return ConversationScreen(itemId: itemId, receiverId: receiverId);
        },
      ),
      GoRoute(
        path: '/aboutUS',
        builder: (BuildContext context, GoRouterState state) {
          return AboutUs();
        },
      ),
      GoRoute(
        path: '/chatHistory',
        builder: (BuildContext context, GoRouterState state) {
          return ChatHistoryScreen();
        },
      ),
    ],
  );
}
