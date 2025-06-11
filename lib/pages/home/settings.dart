import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../stateManagment/Notifier/face_id_notifier.dart';

class FaceIDScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFaceIDEnabled = ref.watch(faceIDProvider);
    final faceIDNotifier = ref.read(faceIDProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text("App Lock"), backgroundColor: Colors.orange),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Require Face ID",
              style: GoogleFonts.brawler(
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
            ),
            SizedBox(width: 40),
            Switch(
              value: isFaceIDEnabled,
              onChanged: (value) => faceIDNotifier.toggleFaceID(value),
              activeColor: Colors.orange,
              inactiveThumbColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
