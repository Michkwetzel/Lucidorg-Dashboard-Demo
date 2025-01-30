// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CatScoreDiffTextHeading extends StatelessWidget {
  const CatScoreDiffTextHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 95,
          child: Text('Category', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 13)),
        ),
        SizedBox(
          width: 60,
          child: Center(child: Text('Score', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 14))),
        ),
        SizedBox(
          width: 52,
          child: Center(
            child: Text('Diff', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 14)),
          ),
        ),
      ],
    );
  }
}
