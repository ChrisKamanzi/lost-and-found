import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/generated/app_localizations.dart';
import '../../../stateManagment/provider/card_detail_provider.dart';
import '../../../widgets/elevated_button.dart';
import '../../message/char2.dart';

class CardDetail extends ConsumerWidget {
  final String itemId;

  CardDetail({super.key, required this.itemId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsyncValue = ref.watch(cardDetailProvider(itemId));
    final notifier = ref.read(cardDetailProvider(itemId).notifier);

    return itemAsyncValue.when(
      loading: () => Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text('Error: $err'))),
      data: (item) {
        bool isFavorited = false;

        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.homeLostFoundDetailfound,
              style: GoogleFonts.brawler(
                textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                    item.imagePath ?? '',
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
                      return Icon(Icons.broken_image, size: 300);
                    },
                  ),
                ),

                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color:
                        item.postType?.toLowerCase() == 'found'
                            ? Colors.purple.shade200
                            : Colors.orange.shade600,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item.postType ?? '',
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
                  item.title ?? '',
                  style: GoogleFonts.brawler(
                    textStyle: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Icon(Icons.lock_clock, color: Colors.grey),
                      SizedBox(width: 6),
                      Text(
                        item.postedAt ?? '',
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
                      icon: Icon(Icons.location_on_rounded, color: Colors.grey),
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
                  AppLocalizations.of(context)!.additionalInfo,
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
                      infoRow(
                        AppLocalizations.of(context)!.brand,
                        item.title ?? '',
                      ),
                      SizedBox(height: 10),
                      infoRow(
                        AppLocalizations.of(context)!.posted,
                        item.postedAt ?? '',
                      ),
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
                      IconButton(
                        icon: Icon(
                          isFavorited ? Icons.favorite : Icons.favorite_border,
                        ),
                        onPressed: () async {
                          await notifier.toggleFavorite(item.id ?? '');
                        },
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
                  AppLocalizations.of(context)!.adPostedby,
                      style: GoogleFonts.brawler(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Text(
                      item.name ?? '',
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
                Button(
                  text: AppLocalizations.of(context)!.sendMessage,
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ConversationScreen(
                              itemId: item.id ?? '',
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
      },
    );
  }
}

Widget infoRow(String title, String value) {
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
