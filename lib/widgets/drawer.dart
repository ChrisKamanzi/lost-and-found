import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/userProvider.dart';


class drawer extends ConsumerWidget {
  const drawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameAsync = ref.watch(nameeProvider);
    final phoneAsync = ref.watch(phoneProvider);

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.orange.shade300),
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
                          onPressed: () => context.go('/account'),
                          icon: Icon(
                            Icons.person,
                            size: 80,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        const Icon(
                          Icons.brightness_3_sharp,
                          size: 60,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    nameAsync.when(
                      data: (name) => Text(
                        name,
                        style: GoogleFonts.brawler(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      loading: () => const Text("Loading name..."),
                      error: (e, _) => const Text("Error"),
                    ),
                    phoneAsync.when(
                      data: (phone) => Text(
                        phone,
                        style: GoogleFonts.brawler(
                          fontWeight: FontWeight.w200,
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
                  onPressed: () {},
                  child: Text(
                    'Favorites',
                    style: GoogleFonts.brawler(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => context.push('/aboutUS'),
                  child: Text(
                    'About us',
                    style: GoogleFonts.brawler(
                      fontWeight: FontWeight.w800,
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => context.push('/settings'),
                  child: Text(
                    'Settings',
                    style: GoogleFonts.brawler(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 200),
                TextButton(
                  onPressed: () => context.push('/congrat'),
                  child: Text(
                    'LogOut',
                    style: GoogleFonts.brawler(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
