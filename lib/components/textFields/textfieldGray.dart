import 'package:flutter/material.dart';

class TextfieldGray extends StatelessWidget {
  final double width;
  final double height;
  final Function(String) onTextChanged;

  const TextfieldGray({super.key, this.width = -1, this.height = -1, required this.onTextChanged});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
        onChanged: onTextChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFF3F3F3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
