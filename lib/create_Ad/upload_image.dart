import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/widgets/elevated_button.dart';

class upload_image extends StatelessWidget {
  const upload_image({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Picture',
              style: GoogleFonts.brawler(
                textStyle: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Add upto 3 pictures use real pictures',
              style: GoogleFonts.brawler(
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w200,
                  color: Colors.deepPurpleAccent.shade400,
                ),
              ),
            ),
            Text(
              'and not catalogs',
              style: GoogleFonts.brawler(
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w200,
                  color: Colors.deepPurpleAccent.shade400,
                ),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.purple.shade200,
                  ),
                  child: Center(
                    child: Icon(Icons.camera_alt, color: Colors.white54, size: 40,),
                  ),
                ),

                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.purple.shade200,
                  ),
                    child: Center(
                      child: Icon(Icons.camera_alt, color: Colors.white54, size: 40,),
                    )
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.purple.shade200,
                  ),
                    child: Center(
                      child: Icon(Icons.camera_alt, color: Colors.white54, size: 40,),
                    )
                ),

                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.purple.shade200,
                  ),
                    child: Center(
                      child: Icon(Icons.camera_alt, color: Colors.white54, size: 40,),
                    )
                ),
              ],
            ),
            
            SizedBox(height: 80),
            
            button(text: 'Continue', onPressed: (){})
          ],
        ),
      ),
    );
  }
}
