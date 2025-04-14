import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/pages/home/all_card.dart';
import 'package:lost_and_found/widgets/drawer.dart';

class lost_found_items extends StatefulWidget {
  const lost_found_items ({super.key});

  @override
  State<lost_found_items > createState() => _homeState();
}

class _homeState extends State<lost_found_items > with SingleTickerProviderStateMixin {
  late TabController _TabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _TabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _TabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        automaticallyImplyLeading: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Items',
              style: GoogleFonts.brawler(
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ),

      bottom: TabBar(
          tabs: [
            Tab(text: 'All'),
            Tab(text: 'Mobile'),
            Tab(text: 'Documents'),
            Tab(text: 'Laptop'),
          ],
          indicatorColor: Colors.yellow,
          indicatorWeight: 4,
          controller: _TabController,
        ),
      ),
   //   drawer: drawer(),
      body: TabBarView(
        controller: _TabController,
        children: [
          Center(child: all_cards()),
          Center(child: all_cards()),
          Center(child: all_cards()),
          Center(child: all_cards()),
        ],
      ),
    );
  }
}
