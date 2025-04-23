import 'package:flutter/material.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/lucid_HR/components/createJobSearch/components/create_job_buttons_widget.dart';
import 'package:platform_front/lucid_HR/components/createJobSearch/components/email_list_widgets/emaillistbody.dart';
import 'package:platform_front/lucid_HR/components/createJobSearch/components/input_title_widget.dart';
import 'package:platform_front/lucid_HR/components/createJobSearch/components/email_template/job_search_dynamic_section.dart';

class JobCreationScreen extends StatelessWidget {
  const JobCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool mobile = false;

    return LayoutBuilder(builder: (context, constraints) {
      final double screenWidth = constraints.maxWidth < 1300 ? constraints.maxWidth : 1300;

      if (screenWidth < 732) {
        mobile = true;
      } else {
        mobile = false;
      }

      return SizedBox(
        width: screenWidth,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 24,
            children: [
              Text(
                "Create Job Search",
                style: kH1TextStyle,
              ),
              mobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 24,
                      children: [
                        InputTitleWidget(),
                        Emaillistbody(),
                        SizedBox(
                          width: 350,
                          child: Row(
                            children: [
                              Expanded(
                                child: JobSearchDynamicSection(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Row(
                      spacing: 32,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          spacing: 24,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputTitleWidget(),
                            Emaillistbody(),
                          ],
                        ),
                        Expanded(
                          child: JobSearchDynamicSection(),
                        ),
                      ],
                    ),
              CreateJobButtonsWidget(),
            ],
          ),
        ),
      );
    });
  }
}
