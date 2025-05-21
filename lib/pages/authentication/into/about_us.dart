import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../services/featureTextAndColors.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> with TickerProviderStateMixin {
  late AnimationController _slideController;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _slideAnimations = List.generate(3, (index) {
      return Tween<Offset>(begin: Offset(1.5, 0), end: Offset.zero)
          .animate(
        CurvedAnimation(
          parent: _slideController,
          curve: Interval(index * 0.2, 1.0, curve: Curves.easeOut),
        ),
      );
    }
    );
    _slideController.forward();
  }
  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade700,
        title: Text(
          'About Us',
          style: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical: 30, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ABOUT US',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
         SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange.shade300, Colors.orange.shade100],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.shade200,
                      blurRadius: 8,
                      offset:  Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  'We believe in the power of community and compassion. Our platform connects people who have lost valuable items with those who’ve found them — making it easier than ever to reunite lost belongings with their rightful owners.',
                  style: GoogleFonts.brawler(
                    textStyle:  TextStyle(
                      fontSize: 18,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
           SizedBox(height: 30),
              Text(
                'FEATURES',
                style: GoogleFonts.lato(
                  textStyle:  TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
            SizedBox(height: 20),
              SizedBox(
                height: 320,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: featureTexts.length,
                  separatorBuilder: (_, __) =>  SizedBox(width: 20),
                  itemBuilder: (context, index) {
                    return SlideTransition(
                      position: _slideAnimations[index],
                      child: Container(
                        width: 280,
                        decoration: BoxDecoration(
                          color: featureColors[index],
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: featureColors[index].withOpacity(0.4),
                              blurRadius: 10,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(24),
                        alignment: Alignment.center,
                        child: Text(
                          featureTexts[index],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.brawler(
                            textStyle:  TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
