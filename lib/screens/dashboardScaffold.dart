import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/companyInfo/companyInfoBody.dart';
import 'package:platform_front/components/dashboard/createAssessment/layouts/createAssessmentBody.dart';
import 'package:platform_front/components/dashboard/navBar/navigationBar.dart';

class Dashboardscaffold extends StatelessWidget {
  const Dashboardscaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 32, left: 32, right: 32, bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NavBar(),
            Expanded(child: CompanyInfoBody()),
          ],
        ),
      ),
    );
  }
}
