import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class drawer extends StatelessWidget {
  const drawer({super.key});

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.only(left: 10, right: 10),
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
                        Icon(
                          Icons.brightness_3_sharp,
                          size: 60,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Text(
                      'David James',
                      style: GoogleFonts.brawler(
                        textStyle: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Text(
                      '+250 788751446',
                      style: GoogleFonts.brawler(fontWeight: FontWeight.w200),
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
                  onPressed: () {
                    //  context.push('/favorites');
                  },
                  child: Text(
                    'Favorites',
                    style: GoogleFonts.brawler(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                TextButton(
                  onPressed: () {
                    context.push('/messages');
                  },
                  child: Text(
                    'Messages',
                    style: GoogleFonts.brawler(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                TextButton(
                  onPressed: () {
                    context.push('/about');
                  },
                  child: Text(
                    'About us',
                    style: GoogleFonts.brawler(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    context.push('/settings');
                  },
                  child: Text(
                    'Settings',
                    style: GoogleFonts.brawler(
                      textStyle: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 200),
                TextButton(
                  onPressed: () => context.push('/congrat'),
                  child: Text(
                    'LogOut',
                    style: GoogleFonts.brawler(
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
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
