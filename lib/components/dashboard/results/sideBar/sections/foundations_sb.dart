import 'package:flutter/material.dart';
import 'package:platform_front/components/global/grayDivider.dart';
import 'package:platform_front/components/global/score_boxes/score_box.dart';
import 'package:platform_front/config/constants.dart';

class FoundationsSB extends StatelessWidget {
  const FoundationsSB({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40, bottom: 20, left: 25, right: 25),
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            spacing: 8,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Foundations", style: kH2PoppinsRegular),
                  SizedBox(width: 8), // Add some spacing between text and icon
                  Tooltip(
                    decoration: kboxShadowNormal,
                    textStyle: TextStyle(color: Colors.black),
                    message: "Most assessments focus solely on productivity (operations) or engagement (workforce) in isolation,\nbut true organizational efficiency emerges when both are measured together",
                    child: Icon(
                      Icons.info_outline,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              GrayDivider(
                width: 250,
              ),
            ],
          ),
          Text('Operations', style: kH2PoppinsLight),
          ScoreBox(height: 50, width: 60, score: 70, textSize: 20, fontWeight: FontWeight.w400),
          Text(
              style: kH6PoppinsLight,
              textAlign: TextAlign.center,
              'Operational efficiency hinges on the seamless integration of alignment and processes, ensuring that every system, workflow, and strategic initiative moves the organization toward its aligned goals, ensuring that priorities, resources, and teams are strategically coordinated.'),
          GrayDivider(
            width: 230,
          ),
          Text("Workforce", style: kH2PoppinsLight),
          ScoreBox(height: 50, width: 60, score: 40, textSize: 20, fontWeight: FontWeight.w400),
          Text(
              style: kH6PoppinsLight,
              textAlign: TextAlign.center,
              'A highly efficient workforce is the result of strong leadership and engaged people, where teams are not only skilled and productive but also motivated and aligned with the organization’s vision, and leadership fosters a culture of accountability, empowerment, and continuous development.'),
        ],
      ),
    );
  }
}
