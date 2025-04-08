import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/create_Ad/upload_image.dart';
import 'package:lost_and_found/widgets/elevated_button.dart';

class select_pic extends StatelessWidget {
  const select_pic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(backgroundColor: Colors.transparent,),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('asset/picture1.jpg', fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 150),
            child: Center(
              child: Column(
               // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select a picture by',
                    style: GoogleFonts.brawler(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Text(
                    'taking a picture or uploading',
                    style: GoogleFonts.brawler(
                      fontWeight: FontWeight.w800,
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'an image',
                    style: GoogleFonts.brawler(
                      textStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple.shade400,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      ),
                      onPressed: (){},
                      child: Text(
                        'Take a Photo',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                  SizedBox(height: 30,),
                  button(text: 'Upload an Image', onPressed: () {

                    Navigator.push(context, MaterialPageRoute(builder: (context) => upload_image()));

                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
