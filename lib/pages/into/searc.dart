import 'package:flutter/material.dart';
import 'package:animated_page_reveal/animated_page_reveal.dart';

class search extends StatefulWidget {
  const search({super.key});

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: AnimatedPageReveal(
              children: [
                PageViewModel(
                    title: 'Report Found or Lost Items',
                    description:  'An item lost and found can easily b'
                        'e reported or an ad could be created',
                    color: Colors.white,
                    imageAssetPath: 'asset/message.png',
                    iconAssetPath: 'asset/logo.png'),

                PageViewModel(
                    title: 'Search Map ',
                    description: 'Search for found items or found close to your location be showed on the map',
                    color: Colors.white54,
                    imageAssetPath: 'asset/logo.png',
                    iconAssetPath: 'asset/message.png'),
                PageViewModel(
                    title: 'Search',
                    description: 'hdjfnjkjfjfjfjfjfjkfkjfkjfjkffjk',
                    color: Colors.white54,
                    imageAssetPath: 'asset/message.png',
                    iconAssetPath: 'asset/message.png, width: 100, height: 100'),

              ]),
        ));
  }
}
