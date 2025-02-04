import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/home/Sections/activeAssessmentWidget.dart';
import 'package:platform_front/components/dashboard/home/Sections/benchmark.dart';
import 'package:platform_front/components/dashboard/home/Sections/currentActionAreaWidget.dart';
import 'package:platform_front/components/dashboard/home/Sections/nextAssessmentWidget.dart';
import 'package:platform_front/components/dashboard/home/Sections/topOppertunitiesWidget/TopOppertunitiesWidget.dart';
import 'package:platform_front/config/constants.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 1008,
                child:  Row(
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
              ),
              const SizedBox(height: 16),
              Row(children: [
                const SizedBox(
                  width: 6,
                ),
                Benchmark(),
                const SizedBox(width: 32),
                ActiveAssessmentWidget(),
              ]),
              const SizedBox(height: 32),
              const SizedBox(
                width: 1000,
                height: 270,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 6,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CurrentActionAreaWidget(),
                        NextAssessmentWidget(
                          nextAssessmentData: '24 Feb 2025',
                        )
                      ],
                    ),
                    SizedBox(
                      width: 32,
                    ),
                    TopOppertunitiesWidget()
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
