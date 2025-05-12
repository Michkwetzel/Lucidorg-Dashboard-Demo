import 'package:flutter/material.dart';
import 'package:platform_front/lucid_ORG/components/home/Sections/row2/home_indicator.dart';
import 'package:platform_front/lucid_ORG/components/results/mainView/sections/diff_matrix/legend_item.dart';
import 'package:platform_front/lucid_ORG/components/results/mainView/sections/diff_matrix/scores_radar_chart.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class HomeRow2 extends StatelessWidget {
  const HomeRow2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 70),
              child: Text('Indicators', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 30)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 410),
              child: Text('Differentiation Matrix', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w300, fontSize: 30)),
            ),
          ],
        ),
        SizedBox(
          width: 1400,
          child: Row(
            spacing: 40,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: HomeIndicators(),
              ),
              Column(
                children: [
                  SizedBox(
                    width: 760,
                    height: 700,
                    child: ClickableRadarChart(),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 16,
                    children: [
                      LegendItem(department: Department.ceo, color: Colors.blue),
                      LegendItem(department: Department.cSuite, color: Colors.green),
                      LegendItem(department: Department.staff, color: Colors.red),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
