import 'package:flutter/material.dart';

class card_detail extends StatelessWidget {
  const card_detail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
          children: [
        Image.asset('asset/shoe.jpeg'),
            Text('Found'),
            Text('Description')

      ]),
    );
  }
}
