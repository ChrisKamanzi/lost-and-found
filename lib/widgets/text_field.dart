import 'package:flutter/material.dart';

class Textfield extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  const Textfield({
    super.key,
    required this.controller,
    this.hintText,
    this.onChanged,
  });

  @override
  State<Textfield> createState() => _TextfieldState();
}

class _TextfieldState extends State<Textfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.transparent,
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.controller,
        onChanged: widget.onChanged, // <-- Step 3

        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 20,
          color: Colors.black,
        ),

        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'You can\'t leave this empty';
          }
          return null;
        },

        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade200,
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: widget.hintText,
        ),
      ),
    );
  }
}
