import 'package:flutter/material.dart';
import 'package:lost_and_found/generated/app_localizations.dart';

class Textfield extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final bool isRequired;

  const Textfield({
    super.key,
    required this.controller,
    this.hintText,
    this.onChanged,
    this.isRequired = false,
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
        boxShadow: const [
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
        onChanged: widget.onChanged,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 20,
          color: Colors.black,
        ),
        validator:
            (value) =>
                widget.isRequired && (value == null || value.isEmpty)
                    ? AppLocalizations.of(context)!.fill_this_please
                    : null,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade200,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: widget.hintText,
        ),
      ),
    );
  }
}
