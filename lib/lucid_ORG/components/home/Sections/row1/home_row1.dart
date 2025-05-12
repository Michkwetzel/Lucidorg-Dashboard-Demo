import 'package:flutter/material.dart';
import 'package:platform_front/lucid_ORG/components/home/Sections/row1/department_score_widget.dart';
import 'package:platform_front/lucid_ORG/components/home/Sections/row1/home_pilars.dart';
import 'package:platform_front/lucid_ORG/components/home/Sections/row1/total_scores.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class HomeRow1 extends StatelessWidget {
  const HomeRow1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Benchmark Overview', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 30)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DepartmentScoreWidget(section: DashboardSection.home,),
            SizedBox(height: 400, child: TotalScores()),
            HomePilars(),
          ],
        ),
      ],
    );
  }
}
