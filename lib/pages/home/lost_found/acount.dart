import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/providers/user_provider.dart';
import '../../../providers/my_item_notifier.dart';

class Account extends ConsumerWidget {
   Account({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(nameeProvider);
    final phone = ref.watch(phoneProvider);
    final email = ref.watch(EmailProvider);
    final myItems = ref.watch(myItemsNotifierProvider);

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.orange.shade700),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.person, size: 150, color: Colors.orange.shade600),
                name.when(
                  data:
                      (name) => Text(
                        name,
                        style: GoogleFonts.brawler(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
                          ),
                        ),
                      ),
                  error: (e, _) => Text("Error"),
                  loading: () => Text("Loading name..."),
                ),
              ],
            ),
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purpleAccent,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.orange.shade700,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.call,
                            size: 40,
                            color: Colors.deepPurpleAccent,
                          ),
                          SizedBox(width: 20),
                          phone.when(
                            data:
                                (phone) => Text(
                                  phone,
                                  style: GoogleFonts.brawler(
                                    textStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                            error: (e, _) => Text("Error"),
                            loading: () => Text("Loading phone..."),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(
                            Icons.email,
                            size: 40,
                            color: Colors.deepPurpleAccent,
                          ),
                    SizedBox(width: 20),
                          email.when(
                            data:
                                (email) => Text(
                                  email,
                                  style: GoogleFonts.brawler(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                            error: (e, _) =>  Text("Error"),
                            loading: () =>  Text("Loading email..."),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Text(
              "My Items",
              style: GoogleFonts.brawler(
                textStyle: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            myItems.when(
              data:
                  (items) => ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Card(
                        elevation: 3,
                        margin:  EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: Image.network(
                            item.imageUrl!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(item.title!),
                          subtitle: Text(
                            '${item.description}\n${item.postedAt}',
                          ),
                          trailing: Text(
                            item.postType!.toUpperCase(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ),
              loading:
                  () => Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ),
              error:
                  (e, _) => Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Failed to load items: $e'),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
