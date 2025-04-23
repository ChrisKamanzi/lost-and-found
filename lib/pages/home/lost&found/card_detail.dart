import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../../../constant/api.dart';
import '../../../models/lost_found_model.dart';
import '../../../widgets/elevated_button.dart';

class cardDetail extends StatefulWidget {
 // final String? itemId;

  const cardDetail({super.key,
   // this.itemId
  });

  @override
  State<cardDetail> createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<cardDetail> {
  late Future<lostFound> itemDetail;

  Future<lostFound> fetchItemDetail(String id) async {
    final response = await http.get(Uri.parse('$apiUrl/items/$id'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return lostFound.fromJson(json['item']);
    } else {
      throw Exception('Failed to load item details');
    }
  }

  @override
  void initState() {
    super.initState();
  //  itemDetail = fetchItemDetail(widget.itemId!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<lostFound>(
      future: itemDetail,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: \${snapshot.error}')),
          );
        } else {
          final item = snapshot.data!;
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
                    child: Image.network(
                      item.imagePath,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color:
                          item.lostStatus.toLowerCase() == 'found'
                              ? Colors.green.shade600
                              : Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item.lostStatus,
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
                    item.title,
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
                        item.daysAgo,
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
                        item.location,
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
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
                        _infoRow('Brand', item.title),
                        const SizedBox(height: 10),
                        _infoRow('Posted', item.daysAgo),
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
                        Icon(
                          Icons.favorite_border,
                          size: 28,
                          color: Colors.pink,
                        ),
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
                        item.title,
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
      },
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
