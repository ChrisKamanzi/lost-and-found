import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildLabel(BuildContext context, String text) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      style: GoogleFonts.brawler(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.orangeAccent
                : Colors.black,
      ),
    ),
  );
}
