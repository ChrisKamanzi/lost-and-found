import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/generated/app_localizations.dart';
import '../../../stateManagment/provider/favorite_provider.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade700,
        title: Text(
          AppLocalizations.of(context)!.favorites,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: favoritesAsync.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text(
            'Check your Connection Please!',
          style: GoogleFonts.brawler(
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700
            )
          ),

        )),
        data: (items) {
          if (items.isEmpty) {
            return Center(child: Text('No favorite items found.'));
          }
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                margin: EdgeInsets.all(12),
                color: Colors.orange[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.orange, width: 1),
                ),
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      item.imageUrl ?? '',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title ?? '',
                            style: GoogleFonts.brawler(
                              textStyle: TextStyle(
                                fontSize: 25,
                                color: Colors.deepOrange,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            item.description ?? '',
                            style: GoogleFonts.brawler(
                              textStyle: TextStyle(fontSize: 15),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Category: ${item.category}',
                            style: GoogleFonts.brawler(
                              textStyle: TextStyle(fontSize: 15),
                            ),
                          ),
                          Text(
                            'Posted: ${item.postedAt}',
                            style: GoogleFonts.brawler(
                              textStyle: TextStyle(fontSize: 15),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Location: ${item.location?.village ?? ''}, '
                            '${item.location?.cell ?? ''}, '
                            '${item.location?.sector ?? ''}, '
                            '${item.location?.district ?? ''}',
                            style: GoogleFonts.brawler(
                              textStyle: TextStyle(fontSize: 15),
                            ),
                          ),

                          Divider(color: Colors.orange),
                          Text(
                            'Posted By: ${item.postedBy?.name} (${item.postedBy?.telephone})',
                            style: GoogleFonts.brawler(
                              textStyle: TextStyle(fontSize: 15),
                            ),
                          ),
                          Text(
                            'From: ${item.postedBy?.location.district}, '
                            '${item.postedBy?.location.sector}',
                            style: GoogleFonts.brawler(
                              textStyle: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
