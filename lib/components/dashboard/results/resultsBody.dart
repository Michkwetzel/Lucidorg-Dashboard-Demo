// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/results/mainView/mainViewBody.dart';
import 'package:platform_front/components/dashboard/results/sideBar/resultsSideBarBody.dart';
import 'package:platform_front/config/constants.dart';

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
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
                  spacing: 32,
                  children: [ResultsSideBar(),
                   MainViewBody()],
                )
              ],
            ),
          ),
        ));
  }
}

class MainSection extends StatelessWidget {
  const MainSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
