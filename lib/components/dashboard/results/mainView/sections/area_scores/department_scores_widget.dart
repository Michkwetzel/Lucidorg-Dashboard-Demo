import 'package:flutter/material.dart';

class DepartmentScoresWidget extends StatelessWidget {
  final int ceo;
  final int cSuite;
  final int staff;

  const DepartmentScoresWidget({super.key, required this.ceo, required this.cSuite, required this.staff});

  final double fontSize = 20;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$ceo%', style: TextStyle(color: Color(0xFF9FAE82), fontSize: fontSize, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
          Text(' | ', style: TextStyle(color: Colors.black, fontSize: fontSize, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
          Text('$cSuite%', style: TextStyle(color: Color(0xFFB3A986), fontSize: fontSize, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
          Text(' | ', style: TextStyle(color: Colors.black, fontSize: fontSize, fontFamily: 'Poppins', fontWeight: FontWeight.w300)),
          Text('$staff%', style: TextStyle(color: Color(0xFF7FAF8C), fontSize: fontSize, fontFamily: 'Poppins', fontWeight: FontWeight.w300))
        ],
      ),
    );
  }
}
