import 'package:flutter/material.dart';

class LineBreak extends StatelessWidget {
  final String colour;

  const LineBreak({this.colour = 'white', super.key});

  @override
  Widget build(BuildContext context) {
    Color paintColour;
    if (colour == 'white') {
      paintColour = Colors.white;
    } else {
      paintColour = Colors.black;
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 200, // Set maximum width
              ),
              color: paintColour,
              height: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Or',
              style: TextStyle(color: paintColour),
            ),
          ),
          Flexible(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 200,
              ),
              color: paintColour,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
