import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/widgets/elevated_button.dart';

class cardDetail extends StatelessWidget {
  const cardDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Found Items',
          style: GoogleFonts.brawler(
            textStyle: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Found Item',
              style: GoogleFonts.brawler(
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'asset/iphone16.jpg',
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green.shade600,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Found',
                style: GoogleFonts.brawler(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'This iPhone was in the Mountains',
              style: GoogleFonts.brawler(
                textStyle: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.lock_clock, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  '2 days ago',
                  style: GoogleFonts.brawler(
                    textStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on_rounded, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  'Kigali',
                  style: GoogleFonts.brawler(
                    textStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              'Additional Information',
              style: GoogleFonts.brawler(
                textStyle: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.yellow.shade600,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.yellow.shade200,
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _infoRow('Color', 'White'),
                  const SizedBox(height: 10),
                  _infoRow('Brand', 'Apple'),
                  const SizedBox(height: 10),
                  _infoRow('Category', 'Gadget'),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Icon(Icons.email, size: 28, color: Colors.deepPurple),
                  Icon(Icons.favorite_border, size: 28, color: Colors.pink),
                  Icon(Icons.share, size: 28, color: Colors.teal),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Text(
                  'Ad posted by ',
                  style: GoogleFonts.brawler(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                Text(
                  'Chris Kamanzi',
                  style: GoogleFonts.brawler(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            button(text: 'Send Message', onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.brawler(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        Text(
          value,
          style: GoogleFonts.brawler(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
