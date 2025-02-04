import 'package:flutter/material.dart';
import 'package:platform_front/components/global/grayDivider.dart';
import 'package:platform_front/components/global/score_boxes/score_box.dart';
import 'package:platform_front/config/constants.dart';

class FoundationsBody extends StatelessWidget {
  const FoundationsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: 335,
                      height: 170,
                      child: Column(
                        children: [
                          Text('Operations', style: kH2PoppinsMedium),
                          SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Text(
                              'Your workforce is in tip top shape.\n\n Everybody is engaged and communication is good',
                              style: kH6PoppinsMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    SubAreaBlock(
                      heading: 'Allignment',
                      text1: 'Growth\nAlignment',
                      score1: 65.7,
                      text2: 'Collaborative\nKPIs',
                      score2: 20.2,
                      text3: 'Alligned Org\nStructure',
                      score3: 80.8,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SubAreaBlock(
                      heading: 'Process',
                      text1: 'Aligned Tech\nStack',
                      score1: 45.7,
                      text2: 'Collaborative\nProcesses',
                      score2: 54.2,
                      text3: 'Meeting\nEfficacy',
                      score3: 43.8,
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 335,
                      height: 170,
                      child: Column(
                        children: [
                          Text('Workforce', style: kH2PoppinsMedium),
                          SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Text(
                              'Your work\n\nforce is in tip top shape. Everybody is engaged and communication is good',
                              style: kH6PoppinsMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    SubAreaBlock(
                      heading: 'People',
                      text1: 'Engaged\nCommunity',
                      score1: 32.7,
                      text2: 'X-Functional\nCommunication',
                      score2: 63.2,
                      text3: 'X-Functional\nAccountability',
                      score3: 61.8,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SubAreaBlock(
                      heading: 'Leadership',
                      text1: 'Empowered\nLeadership',
                      score1: 45.7,
                      text2: 'Purpose\nEverything',
                      score2: 66.2,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Center(
            child: Container(
          width: 1,
          height: 700,
          color: Colors.grey,
        )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              SizedBox(
                height: 180,
              ),
              GrayDivider(),
            ],
          ),
        )
      ],
    );
  }
}

class SubAreaBlock extends StatelessWidget {
  final String heading;
  final String? text1;
  final double? score1;
  final String? text2;
  final double? score2;
  final String? text3;
  final double? score3;

  const SubAreaBlock({super.key, required this.heading, this.text1, this.score1, this.text2, this.score2, this.text3, this.score3});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 335,
      child: Column(
        spacing: 16,
        children: [
          Text(
            heading,
            style: kH4PoppinsRegular,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              spacing: 16,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text1!,
                      style: kH6PoppinsLight,
                    ),
                    ScoreBox(score: score1!, width: 65, height: 42, textSize: 14, fontWeight: FontWeight.w300),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      softWrap: true,
                      text2!,
                      style: kH6PoppinsLight,
                    ),
                    ScoreBox(score: score2!, width: 65, height: 42, textSize: 14, fontWeight: FontWeight.w300),
                  ],
                ),
                if (score3 != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        text3!,
                        style: kH6PoppinsLight,
                      ),
                      ScoreBox(score: score3!, width: 65, height: 42, textSize: 14, fontWeight: FontWeight.w300),
                    ],
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
