import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/widgets/elevated_button.dart';
import 'package:lost_and_found/widgets/text_field.dart';

class requestor_info extends StatelessWidget {
  const requestor_info({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Requestor info.',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(
                    fontSize: 30,

                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: 20),

              Text(
                'NAME.',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 20),
              textfield(),
              SizedBox(height: 20),
              Text(
                'EMAIL.',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 20),
              textfield(),
              SizedBox(height: 20),
              Text(
                'PHONE NO.',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 20),
              textfield(),
              SizedBox(height: 60),
              button(text: 'Done', onPressed: ()=> context.push('/home')),
            ],
          ),
        ),
      ),
    );
  }
}
