import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/generated/app_localizations.dart';
import '../stateManagment/Notifier/user_notifier.dart';
import '../stateManagment/provider/logout_provider.dart';
import '../stateManagment/provider/theme_provider.dart';


  class Draweer extends ConsumerWidget {
  const Draweer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logoutState = ref.watch(logoutNotifierProvider);
    final nameAsync = ref.watch(nameeProvider);
    final phoneAsync = ref.watch(phoneProvider);

    ref.listen<AsyncValue<void>>(logoutNotifierProvider, (previous, next) {
      next.when(
        data: (_) {
          context.go('/login');
        },
        error: (error, _) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Logout error: Check your connection')));
        },
        loading: () {},
      );
    });
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.orange.shade700),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () => context.push('/account'),
                            icon: Icon(
                              Icons.person,
                              size: 80,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          IconButton(
                            onPressed:
                                () =>
                                    ref
                                        .read(themeNotifierProvider.notifier)
                                        .toggleTheme(),
                            icon: Icon(
                              Icons.brightness_3_sharp,
                              size: 60,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      nameAsync.when(
                        data:
                            (name) => Text(
                              name,
                              style: GoogleFonts.brawler(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.color,
                              ),
                            ),
                        loading: () => const Text("App"),
                        error: (e, _) => const Text("Connection Error"),
                      ),
                      phoneAsync.when(
                        data:
                            (phone) => Text(
                              phone,
                              style: GoogleFonts.brawler(
                                fontWeight: FontWeight.w200,
                                color:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.color,
                              ),
                            ),
                        loading: () => const Text("Loading phone..."),
                        error: (e, _) => const Text("Connection Error"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  TextButton(
                    onPressed: () => context.push('/favorite'),
                    child: Text(
                      AppLocalizations.of(context)!.favorites,
                      style: GoogleFonts.brawler(
                        fontSize: 25,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  TextButton(
                    onPressed: () => context.push('/aboutUS'),
                    child: Text(
                      AppLocalizations.of(context)!.aboutUs,
                      style: GoogleFonts.brawler(
                        fontWeight: FontWeight.w800,
                        fontSize: 25,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ),
                   SizedBox(height: 20),
                  TextButton(
                    onPressed: () => context.push('/chatHistory'),
                    child: Text(
                      AppLocalizations.of(context)!.messages,
                      style: GoogleFonts.brawler(
                        fontWeight: FontWeight.w800,
                        fontSize: 25,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () => context.push('/settings'),
                    child: Text(
                   'Settings',
                      style: GoogleFonts.brawler(
                        fontWeight: FontWeight.w800,
                        fontSize: 25,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                  ),

                  SizedBox(height: 200),
                  Padding(
                    padding:  EdgeInsets.only(left: 20),
                    child: TextButton(
                      onPressed:
                          logoutState.isLoading
                              ? null
                              : () {
                                ref
                                    .read(logoutNotifierProvider.notifier)
                                    .logout();
                              },
                      child:
                      logoutState.isLoading
                              ?  CircularProgressIndicator()
                              : Text(
                                AppLocalizations.of(context)!.logout,
                                style: GoogleFonts.brawler(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  color:
                                      Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.color,
                                ),
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
