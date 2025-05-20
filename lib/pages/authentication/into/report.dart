import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class report extends StatefulWidget {
  const report({super.key});

  @override
  State<report> createState() => _SearchPageState();
}

class _SearchPageState extends State<report> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final pages = [
    {
      'title': 'Report Found',
      'description':
          'An item lost and found can easily be reported or an ad could be created',
      'icon': Icons.report,
    },
    {
      'title': 'Search Map',
      'description':
          'Search for found items or found close to your location be showed on the map',
      'icon': Icons.map,
    },
    {
      'title': 'Messaging',
      'description': 'last app allows interaction between users',
      'icon': Icons.message,
    },
  ];

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
              controller: _pageController,
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
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
                        page['title'] as String,
                        style: GoogleFonts.brawler(
                          textStyle: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold
                          )
                        )
                      ),
                      const SizedBox(height: 10),
                      Text(
                        page['description'] as String,
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
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              pages.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 6),
                width: _currentPage == index ? 12 : 8,
                height: _currentPage == index ? 12 : 8,
                decoration: BoxDecoration(
                  color: _currentPage == index ? Colors.orange.shade600 : Colors.grey,
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
