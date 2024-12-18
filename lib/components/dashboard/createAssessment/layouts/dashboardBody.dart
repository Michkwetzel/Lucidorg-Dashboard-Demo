import 'package:flutter/material.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailList/emailListBody.dart';
import 'package:platform_front/components/dashboard/createAssessment/emailList/emailListViewLayout.dart';
import 'package:platform_front/config/constants.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 12,
              ),
              Text(
                'Create Assessment',
                style: kH1TextStyle,
              ),
              SizedBox(height: 40,),
              Emaillistbody(),
            ],
          ),
          EmailTemplateWidget(),
        ],
      ),
    );
  }
}

class EmailTemplateWidget extends StatelessWidget {
  const EmailTemplateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
