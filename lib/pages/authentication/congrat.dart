import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/widgets/elevated_button.dart';

class congrat extends StatelessWidget {
  const congrat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.deepPurpleAccent,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 150, left: 20, right: 10),
            child: Column(
              children: [
                Text(
                  'Congrats!',
                  style: GoogleFonts.brawler(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  'Your Sign up is complete',
                  style: GoogleFonts.brawler(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                
                SizedBox(height: 30,),
                
                SizedBox(
                    height: 350,
                    width: 500,
                    child: Image.asset('asset/success.png',))
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 750, left: 30, right: 30),
            child: Column(
              children: [
                button(
                  text: 'CONTINUE',
                  onPressed: () => context.go('/login'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
