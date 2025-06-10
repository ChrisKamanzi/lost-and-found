import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/generated/app_localizations.dart';
import '../../../stateManagment/Notifier/user_notifier.dart';
import '../../../stateManagment/provider/locale_provider.dart';
import '../../../stateManagment/provider/my_items_provider.dart';

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
                  error:
                      (e, _) => Text("Failed to load name: Connection Error"),
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
                            error:
                                (e, _) =>
                                    Text("phone failed: Connection Error"),
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
                            error:
                                (e, _) =>
                                    Text("email failed: Connection Error"),
                            loading: () => Text("Loading email..."),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: GestureDetector(
                        onTap:
                            () => ref
                                .read(localeProvider.notifier)
                                .setLocale(Locale('en')),
                        child: ClipOval(
                          child: Image.asset(
                            'icons/flags/png/us.png',
                            package: 'country_icons',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    Text(
                      AppLocalizations.of(context)!.english,
                      style: GoogleFonts.brawler(
                        textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 40),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: GestureDetector(
                        onTap:
                            () => ref
                                .read(localeProvider.notifier)
                                .setLocale(Locale('fr')),
                        child: ClipOval(
                          child: Image.asset(
                            'icons/flags/png/fr.png',
                            package: 'country_icons',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      AppLocalizations.of(context)!.french,
                      style: GoogleFonts.brawler(
                        textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 40),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: GestureDetector(
                        onTap:
                            () => ref
                                .read(localeProvider.notifier)
                                .setLocale(const Locale('rw')),
                        child: ClipOval(
                          child: Image.asset(
                            'icons/flags/png/rw.png',
                            package: 'country_icons',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      AppLocalizations.of(context)!.kinyarwanda,
                      style: GoogleFonts.brawler(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 40),

            Text(
              AppLocalizations.of(context)!.myItems,
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
                        margin: EdgeInsets.symmetric(vertical: 8),
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
                    child: Text('Failed to load Items : Connection Error'),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
