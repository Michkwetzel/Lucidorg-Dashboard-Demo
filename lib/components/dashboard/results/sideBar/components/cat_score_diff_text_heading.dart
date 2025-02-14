// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CategoryScoreDiffTextHeading extends StatelessWidget {
  const CategoryScoreDiffTextHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 130,
          child: Text('Category', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 13)),
        ),
        SizedBox(
          width: 60,
          child: Center(child: Text('Score', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 14))),
        ),
        SizedBox(
          width: 55,
          child: Center(
            child: Text('Diff', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 14)),
          ),
        ),
      ],
    );
  }
}
