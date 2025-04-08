import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/pages/home/lost_found_items.dart';

class homepage extends StatelessWidget {
  const homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search, size: 40)),
        ],
      ),
      drawer: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Drawer(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello,',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
              ),
              Text(
                'Kamanzi',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                // color: Colors.purple.shade200,
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.purple.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add_circle_outline_sharp, size: 40),
                      ),

                      Text(
                        'Create an advert',
                        style: GoogleFonts.brawler(
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Report ig you find or lost',
                        style: GoogleFonts.brawler(
                          textStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ),
                      Text(
                        'an Item',
                        style: GoogleFonts.brawler(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30),

              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.yellow.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: GestureDetector(
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => lost_found_items()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, left: 30),
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
                              color: Colors.yellow.shade800,
                              size: 40,
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
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Go through the lost and',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          'found items',
                          style: GoogleFonts.brawler(
                            textStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),

              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.yellow.shade100,
                  borderRadius: BorderRadius.circular(20),

                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.manage_search_rounded, size: 60,),
                      Text(
                        'Search on map',
                        style: GoogleFonts.brawler(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20
                          )
                        ),
                      ),
                      Text(
                        'Search for Items on locations',
                        style: GoogleFonts.brawler(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 13,
                          )
                        ),
                      ),
                      Text(
                        'near you',
                        style: GoogleFonts.brawler(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 13,
                          )
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
