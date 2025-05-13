import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../providers/favoriteNotifier.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Favorites',
          style: TextStyle(
            fontSize: 25,
            color: Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: favoritesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('No favorite items found.'));
          }
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                margin: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      item.imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: GoogleFonts.brawler(
                              textStyle: TextStyle(fontSize: 25),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item.description,
                            style: GoogleFonts.brawler(
                              textStyle: TextStyle(fontSize: 15),
                            ),
                          ),
                          const SizedBox(height: 8),
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
                          const SizedBox(height: 8),
                          Text(
                            'Location: ${item.location.village}, '
                            '${item.location.cell}, '
                            '${item.location.sector},'
                            ' ${item.location.district}',
                            style: GoogleFonts.brawler(
                              textStyle: TextStyle(fontSize: 15),
                            ),
                          ),
                          const Divider(),
                          Text(
                            'Posted By: ${item.postedBy.name} (${item.postedBy.telephone})',
                            style: GoogleFonts.brawler(
                              textStyle: TextStyle(fontSize: 15),
                            ),
                          ),
                          Text(
                            'From: ${item.postedBy.location.district},'
                            ' ${item.postedBy.location.sector}',
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
