import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_and_found/generated/app_localizations.dart';

import '../../services/pages.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _SearchPageState();
}

class _SearchPageState extends State<Report> {
  final PageController pageController = PageController();
  int currentPage = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: TextButton(
              onPressed: () => context.go('/login'),
              child: Text(
                'Skip',
                style: GoogleFonts.brawler(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() => currentPage = index);
              },
              itemBuilder: (context, index) {
                final page = pages[index];
                return Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        page['icon'] as IconData,
                        size: 100,
                        color: Colors.orange.shade700,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        page[AppLocalizations.of(context)!.reportFoundTitle] as String ?? '',
                        style: GoogleFonts.brawler(
                          textStyle: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold
                          )
                        )
                      ),
                      const SizedBox(height: 10),
                      Text(
                        page[AppLocalizations.of(context)!.reportFoundDescription] as String ?? '',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.brawler(
                          textStyle: TextStyle(
                            fontSize: 15,

                          )
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
 SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              pages.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 6),
                width: currentPage == index ? 12 : 8,
                height: currentPage == index ? 12 : 8,
                decoration: BoxDecoration(
                  color: currentPage == index ? Colors.orange.shade600 : Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        SizedBox(height: 30),
        ],
      ),
    );
  }
}
