import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/global/diffTriangleRedWidget.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';

class ResultsBody extends StatelessWidget {
  const ResultsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 1008,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Results",
                            style: kH1TextStyle,
                          ),
                          Text(
                            'Assessment: Q1 2025',
                            style: kH5PoppinsLight,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [ResultsSideBar()],
                )
              ],
            ),
          ),
        ));
  }
}

class ResultsSideBar extends ConsumerWidget {
  const ResultsSideBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 350,
      height: 650,
      decoration: kboxShadowNormal,
      child: ref.watch(resultsDisplayProvider),
    );
  }
}

class ResultsSideOverview extends StatelessWidget {
  const ResultsSideOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding:  EdgeInsets.only(top: 40, bottom: 20, left: 25, right: 25),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Overall Score",
            style: kH2PoppinsLight,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            '55.7%',
            style: kH3TotalScoreLight,
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            'Overall Differentiation',
            style: kH3PoppinsLight,
          ),
          SizedBox(
            height: 8,
          ),
          DiffTriangleRedWidget(value: '~38%', size: Diffsize.H1)
        ],
      ),
    );
  }
}
