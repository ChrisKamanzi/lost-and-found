import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/constant/api.dart';
import 'package:lost_and_found/generated/app_localizations.dart';
import 'package:lost_and_found/providers/them_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/user_provider.dart';

class Draweer extends ConsumerWidget {
  const Draweer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameAsync = ref.watch(nameeProvider);
    final phoneAsync = ref.watch(phoneProvider);

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
                        error: (e, _) => const Text("Error"),
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
                        error: (e, _) => const Text("Error"),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 80),
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
                  const SizedBox(height: 20),

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
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 200),
                  TextButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      final token = prefs.getString('authToken');

                      if (token != null) {
                        try {
                          final dio = Dio();
                          final response = await dio.post(
                            '$apiUrl/logout',
                            options: Options(
                              headers: {
                                'Authorization': 'Bearer $token',
                                'Accept': 'application/json',
                              },
                            ),
                          );
                          if (response.statusCode == 200) {
                            print('logged out succesfully');
                            await prefs.remove('authToken');
                            if (context.mounted) {
                              context.go('/login');
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Logout failed on server.'),
                              ),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Logout error: $e')),
                          );
                        }
                      } else {
                        await prefs.remove('authToken');
                        if (context.mounted) {
                          context.go('/login');
                        }
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context)!.logout,
                      style: GoogleFonts.brawler(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
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
