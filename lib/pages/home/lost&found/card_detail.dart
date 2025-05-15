import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constant/api.dart';
import '../../../models/lost_found_model.dart';
import '../../../widgets/elevated_button.dart';
import '../../message/char2.dart';

class cardDetail extends StatefulWidget {
  final String itemId;

  cardDetail({super.key, required this.itemId});

  @override
  State<cardDetail> createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<cardDetail> {
  late Future<LostFound> itemFuture;
  bool isFavorited = false;

  Future<void> toggleFavorite(String itemId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token == null) {
      print('[ERROR] Auth token not found');
      return;
    }

    final Dio dio = Dio();
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      print('[API REQUEST] POST $apiUrl/items/$itemId/favorite');
      final response = await dio.post('$apiUrl/items/$itemId/favorite');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('[SUCCESS] Favorite toggled successfully');
        setState(() {
          isFavorited = !isFavorited;
        });
      } else {
        print('[ERROR] Failed to toggle favorite: ${response.statusCode}');
      }
    } catch (e) {
      print('[ERROR] toggleFavorite: $e');
    }
  }

  Future<LostFound> fetchItemById(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    print('[SharedPreferences] Retrieved token: $token');
    if (token == null) {
      throw Exception('Token not found in local storage');
    }
    final Dio dio = Dio();
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    try {
      print('[API REQUEST] GET $apiUrl/items/$id');
      final response = await dio.get('$apiUrl/items/$id');
      print('[API RESPONSE] Status Code: ${response.statusCode}');
      print('[API RESPONSE] Body: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data;
        return LostFound.fromJson(data['item']);
      } else {
        throw Exception('Failed to load item: ${response.statusCode}');
      }
    } catch (e) {
      print('[ERROR] fetchItemById: $e');
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    itemFuture = fetchItemById(widget.itemId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LostFound>(
      future: itemFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else {
          final item = snapshot.data!;
          print('[INFO] Loaded item: ${item.title}');
          print('[INFO] Image path: ${item.imagePath}');

          return Scaffold(
            backgroundColor: Colors.grey.shade100,
            appBar: AppBar(
              title: Text(
                'Found Item',
                style: GoogleFonts.brawler(
                  textStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              elevation: 0,
              backgroundColor: Colors.orange.shade700,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 25),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      item.imagePath,
                      height: 350,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.orange.shade700,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        print(
                          '[IMAGE ERROR] Failed to load: ${item.imagePath}',
                        );
                        print('[STACK TRACE] $stackTrace');
                        return Icon(Icons.broken_image, size: 300);
                      },
                    ),
                  ),

                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color:
                          item.postType.toLowerCase() == 'found'
                              ? Colors.purple.shade200
                              : Colors.orange.shade600,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item.postType,
                      style: GoogleFonts.brawler(
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white54
                                  : Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Text(
                    item.title,
                    style: GoogleFonts.brawler(
                      textStyle: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  SizedBox(height: 10),
                  Padding(
                    padding:  EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Icon(Icons.lock_clock, color: Colors.grey),
                        SizedBox(width: 6),
                        Text(
                          item.postedAt,
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
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => context.push('/mapItem'),
                        icon: Icon(
                          Icons.location_on_rounded,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        "${item.location['village']}, ${item.location['sector']}, ${item.location['district']}",
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

                  SizedBox(height: 30),
                  Text(
                    'Additional Information',
                    style: GoogleFonts.brawler(
                      textStyle: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.black54,
                      ),
                    ),
                  ),

                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade600,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.yellow.shade200,
                          blurRadius: 10,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _infoRow('Brand', item.title),
                        SizedBox(height: 10),
                        _infoRow('Posted', item.postedAt),
                      ],
                    ),
                  ),

                  SizedBox(height: 25),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 10,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.email, size: 28, color: Colors.deepPurple),
                        GestureDetector(
                          onTap: () => toggleFavorite(item.id),
                          child: Icon(
                            isFavorited
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 28,
                            color: isFavorited ? Colors.red : Colors.pink,
                          ),
                        ),

                        GestureDetector(
                          onTap: () => context.push('/map'),
                          child: Icon(
                            Icons.location_on_rounded,
                            size: 28,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 25),
                  Row(
                    children: [
                      Text(
                        'Ad posted by',
                        style: GoogleFonts.brawler(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      Text(
                        item.name,
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

                  SizedBox(height: 30),
                  button(
                    text: 'Send Message',
                    onPressed: () {
                      print('[ACTION] Chat button pressed');
                      print('itemId: ${item.id}');
                      print('userId: ${item.userId}');

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => ConversationScreen(
                                itemId: item.id,
                                receiverId: item.userId,
                                name: item.name,
                              ),
                        ),
                      );
                    },
                  ),
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
