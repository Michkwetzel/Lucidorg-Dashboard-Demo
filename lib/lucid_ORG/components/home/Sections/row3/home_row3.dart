import 'package:flutter/material.dart';
import 'package:platform_front/lucid_ORG/components/home/Sections/row3/home_focus_areas.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class HomeRow3 extends StatelessWidget {
  const HomeRow3({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text('Focus Areas', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 30)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeFocusAreas(
                section: FocusSection.diffPyramid,
              ),
              HomeFocusAreas(
                section: FocusSection.scorePyramid,
              )
            ],
          ),
        ],
      ),
    );
  }
}
