import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/createAssessment/layouts/dashboardBody.dart';
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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NavBar(),
            DashboardBody(),
          ],
        ),
      ),
    );
  }
}
