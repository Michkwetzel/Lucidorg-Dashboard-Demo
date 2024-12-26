// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class StyledDropdown extends StatefulWidget {
  final List<String> items;
  final Function(String) onChanged;

  const StyledDropdown({
    super.key,
    required this.items,
    required this.onChanged,
  });

  @override
  State<StyledDropdown> createState() => _StyledDropdownState();
}

class _StyledDropdownState extends State<StyledDropdown> {
  late String selectedValue = widget.items[0];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButton<String>(
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        value: selectedValue,
        isExpanded: true,
        underline: Container(),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        icon: const Icon(Icons.arrow_drop_down),
        onChanged: (String? value) {
          if (value != null) {
            setState(() {
              selectedValue = value;
            });
            widget.onChanged(value);
          }
        },
        items: widget.items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
