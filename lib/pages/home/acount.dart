import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/widgets/drawer.dart';

class account extends StatelessWidget {
  const account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: drawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.person, size: 150, color: Colors.grey),
                Text(
                  'David',
                  style: GoogleFonts.brawler(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),
        
            SizedBox(
              height: 280,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 4),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50, left: 20, right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.call,
                              size: 40,
                              color: Colors.deepPurpleAccent,
                            ),
                            SizedBox(width: 20),
                            Text(
                              '+250 788751446',
                              style: GoogleFonts.brawler(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
        
                        Row(
                          children: [
                            Icon(
                              Icons.email,
                              size: 40,
                              color: Colors.deepPurpleAccent,
                            ),
                            SizedBox(width: 20),
        
                            Text(
                              'David@gmail.com',
                              style: GoogleFonts.brawler(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
        
                        Row(
                          children: [
                            Icon(
                              Icons.alternate_email,
                              size: 40,
                              color: Colors.deepPurpleAccent,
                            ),
                            SizedBox(width: 20),
        
                            Text(
                              '@David',
                              style: GoogleFonts.brawler(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
