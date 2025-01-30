import 'package:flutter/material.dart';
import 'package:platform_front/components/global/diffTriangleRedWidget.dart';
import 'package:platform_front/config/enums.dart';

class AreaScoreDiffBox extends StatelessWidget {
  final String text;
  final double diff;

  const AreaScoreDiffBox({
    super.key,
    required this.text,
    required this.diff,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 205,
      height: 105,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.black, // Border color
          width: 1, // Border width
        ),
      ),
      child: Column(
        spacing: 8,
        children: [
          Text(text, style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 22)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DiffTriangleRedWidget(
                value: diff,
                size: Diffsize.H1,
                allRed: true,
              )
            ],
          ),
        ],
      ),
    );
  }
}
