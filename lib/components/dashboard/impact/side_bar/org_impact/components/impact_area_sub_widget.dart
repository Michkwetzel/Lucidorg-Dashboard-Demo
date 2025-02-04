// // ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:platform_front/config/constants.dart';

class ImpactAreaSubWidget extends StatelessWidget {
  final int impactValue;
  final String heading;
  final String body;

  const ImpactAreaSubWidget({
    super.key,
    required this.impactValue,
    required this.heading,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 24,
              height: 20,
              margin: const EdgeInsets.only(right: 11),
              decoration: BoxDecoration(
                color: const Color(0xFFCD1717),
                borderRadius: BorderRadius.circular(6),
              ),
              alignment: Alignment.center,
              child: Text(
                impactValue.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
            Flexible(
              child: Text(
                heading,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 35, top: 6),
          child: Text(body, style: kH7PoppinsLight),
        ),
        SizedBox(height: 12)
      ],
    );
  }
}

// class ImpactSideBar extends StatelessWidget {
//   const ImpactSideBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(left: 5, bottom: 5),
//       width: 350,
//       height: 850,
//       decoration: kboxShadowNormal,
//       child: OrgImpactSideBar(),
//     );
//   }
// }

// class OrgImpactSideBar extends StatelessWidget {
//   const OrgImpactSideBar({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(top: 40, bottom: 20, left: 25, right: 25),
//       child: Column(
//         spacing: 32,
//         children: [
//           Text('Impact Areas', style: kH2PoppinsLight),
//           ImpactAreaWidget(mainArea: MainArea.alignment),
//           ImpactAreaWidget(mainArea: MainArea.leadership),
//           ImpactAreaWidget(mainArea: MainArea.people),
//           ImpactAreaWidget(mainArea: MainArea.process),
//         ],
//       ),
//     );
//   }
// }

// class ImpactAreaWidget extends StatelessWidget {
//   // Widget containing the main category header and rows of individual impact  area
//   final MainArea mainArea;
//   const ImpactAreaWidget({super.key, required this.mainArea});

//   @override
//   Widget build(BuildContext context) {
//     String heading = '';
//     Widget body;

//     Widget getAlignmentWidget() {
//       return Column(
//         children: [
//           GrowthAlignWidget(),
//           CollabKPIWidget(),
//         ],
//       );
//     }

//     Widget getLeadershipWidget() {
//       return PurposeDrivenWidget();
//     }

//     Widget getPeopleWidget() {
//       return CrossFuncCommsWidget();
//     }

//     Widget getProcessWidget() {
//       return MeetingEfficacyWidget();
//     }

//     switch (mainArea) {
//       case MainArea.alignment:
//         heading = 'Alignment';
//         body = getAlignmentWidget();
//         break;
//       case MainArea.people:
//         heading = 'People';
//         body = getPeopleWidget();
//         break;
//       case MainArea.process:
//         body = getProcessWidget();
//         heading = 'Process';
//         break;
//       case MainArea.leadership:
//         body = getLeadershipWidget();
//         heading = 'Leadership';
//         break;
//     }
//     return Column(
//       spacing: 8,
//       children: [Text(heading, style: kH3PoppinsRegular), body],
//     );
//   }
// }

// class MeetingEfficacyWidget extends StatelessWidget {
//   const MeetingEfficacyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ImpactAreaSubWidget(impactValue: 1, heading: "Meeting Efficacy:", body: 'Streamline meeting processes agendas, attendees and number of meetings taking place');
//   }
// }

// class CrossFuncCommsWidget extends StatelessWidget {
//   const CrossFuncCommsWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ImpactAreaSubWidget(impactValue: 1, heading: "Cross-Functional Communication:", body: 'Develop a plan to ensure 360 degrees communication across the org');
//   }
// }

// class GrowthAlignWidget extends StatelessWidget {
//   const GrowthAlignWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ImpactAreaSubWidget(impactValue: 1, heading: "Growth Alignment:", body: 'Aligned growth vision and milestone plan (1,5,10 yrs)');
//   }
// }

// class CollabKPIWidget extends StatelessWidget {
//   const CollabKPIWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ImpactAreaSubWidget(impactValue: 2, heading: "Collaborative KPIs:", body: 'Determine 3-5 collaborative KPI. Define decision making, responsibility, work streams and reporting');
//   }
// }

// class PurposeDrivenWidget extends StatelessWidget {
//   const PurposeDrivenWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ImpactAreaSubWidget(
//         impactValue: 1, heading: "Purpose Driven:", body: 'Purpose driven culture where the purpose becomes apart of both the internal and eternal stakeholders during the onboarding process');
//   }
// }

// class ImpactAreaSubWidget extends StatelessWidget {
//   // Widget for individual impact areas like growth alignment/purpose driven
//   final int impactValue;
//   final String heading;
//   final String body;

//   const ImpactAreaSubWidget({super.key, required this.impactValue, required this.heading, required this.body});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       spacing: 8,
//       children: [
//         Row(
//           children: [
//             SizedBox(
//               width: 35,
//               child: Container(
//                   width: 24,
//                   height: 20,
//                   decoration: BoxDecoration(
//                     color: Color(0xFFCD1717),
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                   child: Text(
//                     impactValue.toString(),
//                     style: TextStyle(color: Colors.white, fontSize: 12),
//                   )),
//             ),
//             Text(
//               heading,
//               style: TextStyle(color: Colors.black, fontSize: 17, fontFamily: 'Poppins', fontWeight: FontWeight.w300),
//             )
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 35),
//           child: Text(
//             body,
//             style: kH7PoppinsLight,
//           ),
//         )
//       ],
//     );
//   }
// }

// First, create a model to represent impact areas
