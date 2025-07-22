import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lost_and_found/pages/authentication/congrat.dart';
import 'package:lost_and_found/pages/authentication/forgot_password.dart';
import 'package:lost_and_found/pages/authentication/forgot_token.dart';
import 'package:lost_and_found/pages/authentication/into/about_us.dart';
import 'package:lost_and_found/pages/authentication/into/language_selection.dart';
import 'package:lost_and_found/pages/authentication/into/report.dart';
import 'package:lost_and_found/pages/authentication/into/splash_screen.dart';
import 'package:lost_and_found/pages/authentication/login.dart';

import 'package:lost_and_found/pages/authentication/sign_up.dart';
import 'package:lost_and_found/pages/create_Ad/create_ad_reg.dart';
import 'package:lost_and_found/pages/home/security_ alert.dart';
import 'package:lost_and_found/pages/home/home.dart';
import 'package:lost_and_found/pages/authentication/into/acount.dart';
import 'package:lost_and_found/pages/home/lost_found/card_detail.dart';
import 'package:lost_and_found/pages/home/lost_found/favorite_screen.dart';
import 'package:lost_and_found/pages/home/lost_found/lost_found_items.dart';
import 'package:lost_and_found/pages/home/settings.dart';

import 'package:lost_and_found/pages/message/chat.dart';
import 'package:lost_and_found/pages/message/conversation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lost_and_found/pages/search_on_map/map.dart';
import 'package:lost_and_found/pages/search_on_map/map_item.dart';
import 'package:lost_and_found/stateManagment/provider/locale_provider.dart';
import 'package:lost_and_found/stateManagment/provider/theme_provider.dart';
import 'generated/app_localizations.dart';
import 'l10n/kinyarwanda_material_localisation.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.black)),
);

final darkTheme = ThemeData(

  brightness: Brightness.dark,
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.black,
  textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.white)
  ),
);

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "apii.env");
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final themeMode = ref.watch(themeNotifierProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        KinyarwandaMaterialLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('fr'), Locale('rw')],
      locale: locale,
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale != null) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode) {
              return supportedLocale;
            }
          }
        }
        return const Locale('en');
      },
    );
  }

  final GoRouter _router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (BuildContext context, GoRouterState state) {
          return SplashScreen();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return Login();
        },
      ),
      GoRoute(
        path: '/signUp',
        builder: (BuildContext context, GoRouterState state) {
          return SignUp();
        },
      ),
      GoRoute(
        path: '/homepage',
        builder: (BuildContext context, GoRouterState state) {
          return Homepage();
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
          return Report();
        },
      ),
      GoRoute(
        path: '/cardDetail/:itemId',
        builder: (BuildContext context, GoRouterState state) {
          final itemId = state.pathParameters['itemId']!;
          return CardDetail(itemId: itemId);
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
      GoRoute(
        path: '/language',
        builder: (BuildContext context, GoRouterState state) {
          return LanguageSelectionScreen();
        },
      ),
      GoRoute(
        path: '/settings',
        builder: (BuildContext context, GoRouterState state) {
          return FaceIDScreen();
        },
      ),
      GoRoute(
        path: '/alert',
        builder: (BuildContext context, GoRouterState state) {
          return SecurityAlertPage();
        },
      ),
    ],
  );
}
