import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/global_components/buttons/CallToActionButton.dart';
import 'package:platform_front/global_components/buttons/secondaryButton.dart';
import 'package:platform_front/global_components/gray_divider.dart';
import 'package:platform_front/lucid_HR/config/enums_hr.dart';
import 'package:platform_front/lucid_HR/config/providers.dart';
import 'package:platform_front/lucid_HR/createJobSearch/components/benchmark_widgets/benchmarks_widget.dart';
import 'package:platform_front/lucid_HR/createJobSearch/components/create_job_buttons_widget.dart';
import 'package:platform_front/lucid_HR/createJobSearch/components/email_list_widgets/emaillistbody.dart';
import 'package:platform_front/lucid_HR/createJobSearch/components/input_title_widget.dart';
import 'package:platform_front/lucid_HR/createJobSearch/components/email_template/email_template_widget.dart';
import 'package:platform_front/lucid_HR/createJobSearch/components/email_template/job_search_dynamic_section.dart';
import 'package:platform_front/lucid_HR/global_components/heading_and_divider.dart';
import 'package:platform_front/lucid_HR/notifiers/job_creation_notifier.dart';
import 'package:platform_front/lucid_ORG/components/global_org/textfieldGray.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

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
