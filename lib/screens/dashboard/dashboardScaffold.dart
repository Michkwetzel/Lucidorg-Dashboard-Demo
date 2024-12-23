import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/createAssessment/layouts/createAssessmentBody.dart';
import 'package:platform_front/components/dashboard/navBar/navigationBar.dart';

class Dashboardscaffold extends StatelessWidget {
  const Dashboardscaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(32.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NavBar(),
            Expanded(child: CreateAssessmentBody()),
          ],
        ),
      ),
    );
  }
}
