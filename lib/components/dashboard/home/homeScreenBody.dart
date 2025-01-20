import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/home/Sections/ActiveAssessmentWidget.dart';
import 'package:platform_front/components/dashboard/home/Sections/EfficiencyScoresWidget.dart';
import 'package:platform_front/components/dashboard/home/Sections/currentActionAreaWidget.dart';
import 'package:platform_front/config/constants.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Home",
                  style: kH1TextStyle,
                ),
                Text(
                  'Assessment: Q1 2025',
                  style: kH5PoppinsLight,
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(children: [
              const SizedBox(
                width: 6,
              ),
              EfficiencyScoresWidget(),
              const SizedBox(width: 32),
              ActiveAssessmentWidget(),
            ]),
            const SizedBox(height: 32),
            SizedBox(
              width: 1000,
              height: 270,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 6,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CurrentActionAreaWidget(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(color: Color(0xFFE0E0E0), borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          'Next Assessment: 24 Feb 2025',
                          style: kH5PoppinsRegular,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TopOppertunitiesWidget extends StatelessWidget {
  const TopOppertunitiesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kboxShadowNormal,
      child: Column(
        children: [
          Text('Top Opportunities'),
        ],
      ),
    );
  }
}

class TopOppertunitiesRow extends StatelessWidget {
  const TopOppertunitiesRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Text('Meeting afficacy'), Container(child: ,)],
    );
  }
}
