import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/widgets/elevated_button.dart';
import 'package:lost_and_found/widgets/text_field.dart';
import 'package:riverpod/riverpod.dart';

class create_ad_reg extends StatefulWidget {
  const create_ad_reg({super.key});

  @override
  State<create_ad_reg> createState() => _create_ad_regState();
}

class _create_ad_regState extends State<create_ad_reg> {
  @override
  Widget build(BuildContext context) {
    String? selectedCategory;
    String? selectedLocation;

    final List<String> category = ['Mobile', 'Laptop', 'Documents'];

    return Scaffold(appBar: AppBar(
    ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only( left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create ad',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Category',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.transparent,
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButtonFormField<String>(
                  value: selectedCategory,
                  items: ['Mobile', 'Laptop', 'Documents'].map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(
                        category,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedCategory = value;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  icon: Icon(Icons.arrow_drop_down),
                  dropdownColor: Colors.grey.shade100,
                ),
              ),
              SizedBox(height: 20),
        
              Text(
                'Post Type',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                ),
              ),
              SizedBox(height: 20),
        
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.purple.shade200,
                    ),
                    child: Center(child: Text('Lost',
                    style: GoogleFonts.brawler(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white
                      )
                    ),)),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.yellow.shade100,
                    ),
                    child: Center(child: Text('Found',
                    style: GoogleFonts.brawler(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white
                      )
                    ),)),
                  ),
                ],
              ),
              SizedBox(height: 20),
        
              Text(
                'Title',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                ),
              ),
              SizedBox(height: 20),
              textfield(),
              SizedBox(height: 20),
              Text(
                'Description',
                style: GoogleFonts.brawler(
                  textStyle: GoogleFonts.brawler(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              textfield(),
              SizedBox(height: 20),
              Text(
                'Location',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  )
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.transparent,
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButtonFormField<String>(
                  value: selectedCategory,
                  items: ['Lagos', 'Kigali', 'Bujumbura'].map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(
                        category,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedCategory = value;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  icon: Icon(Icons.arrow_drop_down),
                  dropdownColor: Colors.grey.shade100,
                ),
              ),              SizedBox(height: 20),
              button(text: 'Contine', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
