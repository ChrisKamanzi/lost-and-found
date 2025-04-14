import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/create_Ad/select_pic.dart';
import 'package:lost_and_found/models/create_ad_model.dart';
import 'package:lost_and_found/widgets/drawer.dart';
import 'package:lost_and_found/widgets/elevated_button.dart';
import 'package:lost_and_found/widgets/text_field.dart';
import 'package:riverpod/riverpod.dart';

import '../providers/create_ad_provider.dart';

class create_ad_reg extends ConsumerWidget {
  const create_ad_reg({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createAd = ref.watch(createAdProvider);

    String? selectedCategory;
    String? selectedLocation;

    final List<String> category = ['Mobile', 'Laptop', 'Documents'];
    final List<String> location = ['Kigali', 'Lagos', 'Bujumbura'];

    TextEditingController _title = TextEditingController();
    TextEditingController _description = TextEditingController();

    void save() {

      CreateAd ad = CreateAd(
        selectedCategory: category!,
        //  post_type: post_type,
        title: _title.text,
        description: _description.text,
        location: location!,
      );

      print('This is the data: ${ad.toJson()}');

      context.push('/select_pic');
    };
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true),
    //  drawer: drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create ad',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Category',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
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
                  items:
                      ['Mobile', 'Laptop', 'Documents'].map((String category) {
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
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
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
                  textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
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
                    child: Center(
                      child: Text(
                        'Lost',
                        style: GoogleFonts.brawler(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.yellow.shade800,
                    ),
                    child: Center(
                      child: Text(
                        'Found',
                        style: GoogleFonts.brawler(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              Text(
                'Title',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: 20),
              textfield(controller: _title,

              ),
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
              textfield(controller: _description),
              SizedBox(height: 20),
              Text(
                'Location',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
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
                  value: selectedLocation,
                  items:
                      location.map((String Location) {
                        return DropdownMenuItem<String>(
                          value: Location,
                          child: Text(
                            Location,
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
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  icon: Icon(Icons.arrow_drop_down),
                  dropdownColor: Colors.grey.shade100,
                ),
              ),
              SizedBox(height: 20),
              button(text: 'Contine', onPressed: save),
            ],
          ),
        ),
      ),
    );
  }
}
