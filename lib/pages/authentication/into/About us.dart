import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      return Tween<Offset>(begin: Offset(1.5, 0), end: Offset.zero).animate(
        CurvedAnimation(
          parent: _slideController,
          curve: Interval(
            index * 0.2, // delay for each
            1.0,
            curve: Curves.easeOut,
          ),
        ),
      );
    });

    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final featureTexts = [
      'Report Lost Item',
      'Locate Found Item',
      'Instant Messaging',
    ];

    final colors = [
      Colors.orange.shade400,
      Colors.blue.shade200,
      Colors.deepPurpleAccent.shade200,
    ];

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.orange.shade400),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
          child: Column(
            children: [
              Text(
                'ABOUT US',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 45,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 10),
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.amberAccent,
                  ),
                  child: Text(
                    ' We believe in the power of community and compassion. '
                    'Our platform connects people who have lost valuable items with those who’ve found them,'
                    ' making it easier than ever to reunite lost belongings with their rightful owners. ',
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'FEATURES',
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 30),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(3, (index) {
                    return SlideTransition(
                      position: _slideAnimations[index],
                      child: Row(
                        children: [
                          Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                              color: colors[index],
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              featureTexts[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                height: 1.3,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
