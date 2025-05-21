import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/widgets/drawer.dart';

import '../../providers/user_provider.dart';

class Homepage extends ConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameAsyncValue = ref.watch(nameeProvider);

    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(),
      body: nameAsyncValue.when(
        loading: () => Center(child: CircularProgressIndicator(color: Colors.orange.shade700,)),
        error: (e, _) => Center(child: Text('Failed to load name: $e')),
        data:
            (name) => SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Hello',
                          style: GoogleFonts.brawler(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 30,
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Text(
                          name,
                          style: GoogleFonts.brawler(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () => context.push('/create_add'),
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.purple.shade200,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding:  EdgeInsets.only(top: 30, left: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.add_circle_outline_sharp, size: 40),
                              Text(
                                'Create an advert',
                                style: GoogleFonts.brawler(
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: Theme.of(context).brightness == Brightness.dark
                                        ? Colors.orangeAccent
                                        : Colors.black,                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Report if you find or lost',
                                style: GoogleFonts.brawler(
                                  textStyle: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).brightness == Brightness.dark
                                        ? Colors.black
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              Text(
                                'an Item',
                                style: GoogleFonts.brawler(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    fontSize: 13,
                                    color: Theme.of(context).brightness == Brightness.dark
                                      ? Colors.black // custom color for dark mode
                                      : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () => context.push('/lost_found'),
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.orange.shade600,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding:  EdgeInsets.only(top: 30, left: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.lock_person_outlined,
                                    color: Colors.yellow.shade800,
                                    size: 40,
                                  ),
                                  Icon(
                                    Icons.umbrella,
                                    color: Colors.orange.shade300,                                     size: 40,
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Lost & found Items',
                                style: GoogleFonts.brawler(
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors
                                                .orangeAccent
                                            : Colors
                                                .black,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Go through the lost and',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color:
                                      Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors
                                              .black
                                          : Colors.black,
                                ),
                              ),
                              Text(
                                'found items',
                                style: GoogleFonts.brawler(
                                  textStyle: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors
                                                .black
                                            : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () => context.push('/map'),
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding:  EdgeInsets.only(left: 30, top: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.manage_search_rounded,
                                size: 60,
                                color:
                                    Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors
                                            .orangeAccent
                                        : Colors.blueGrey,
                              ),
                              Text(
                                'Search on map',
                                style: GoogleFonts.brawler(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                    color:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors
                                                .orangeAccent // custom color for dark mode
                                            : Colors.black,
                                  ),
                                ),
                              ),
                              Text(
                                'Search for lost FoundItems on locations',
                                style: GoogleFonts.brawler(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 13,
                                    color: Theme.of(context).brightness == Brightness.dark
                                        ? Colors.black
                                        : Colors.black,
                                  ),
                                ),
                              ),
                              Text(
                                'near you',
                                style: GoogleFonts.brawler(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 13,
                                    color: Theme.of(context).brightness == Brightness.dark
                                        ? Colors.black // custom color for dark mode
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
