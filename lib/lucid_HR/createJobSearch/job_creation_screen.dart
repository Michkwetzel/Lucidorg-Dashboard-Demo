import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/global_components/buttons/CallToActionButton.dart';
import 'package:platform_front/global_components/buttons/secondaryButton.dart';
import 'package:platform_front/global_components/gray_divider.dart';
import 'package:platform_front/lucid_HR/config/enums_hr.dart';
import 'package:platform_front/lucid_HR/config/providers.dart';
import 'package:platform_front/lucid_HR/createJobSearch/components/benchmark_widgets/benchmarks_widget.dart';
import 'package:platform_front/lucid_HR/createJobSearch/components/email_list_widgets/emaillistbody.dart';
import 'package:platform_front/lucid_HR/createJobSearch/components/input_title_widget.dart';
import 'package:platform_front/lucid_HR/global_components/heading_and_divider.dart';
import 'package:platform_front/lucid_HR/notifiers/job_creation_notifier.dart';
import 'package:platform_front/lucid_ORG/components/global_org/textfieldGray.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';

class JobCreationScreen extends StatelessWidget {
  const JobCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
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
              ButtonsWidget(),
            ],
          ),
        ),
      );
    });
  }
}

class ButtonsWidget extends ConsumerWidget {
  const ButtonsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(jobCreationProvider).newJobSearchSection == NewJobSearchSection.chooseBenchmarks) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CallToActionButton(
            onPressed: () => ref.read(jobCreationProvider.notifier).onNextClicked(),
            buttonText: "Next",
          ),
        ],
      );
    } else {
      return Row(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Secondarybutton(
            onPressed: () => ref.read(jobCreationProvider.notifier).onBackClicked(),
            buttonText: "Back",
          ),
          CallToActionButton(
            onPressed: () {
              ref.read(googlefunctionserviceProvider.notifier).createNewJobSearch(ref.read(jobCreationProvider.notifier).getAllData());
            },
            buttonText: "Create Job Search",
          )
        ],
      );
    }
  }
}

class EmailTemplateWidget extends ConsumerWidget {
  const EmailTemplateWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      spacing: 12,
      children: [
        HeadingAndDivider(
          heading: "Benchmarks",
        ),
        SimpleTextFieldGray(
          heading: "Email From:",
          hintText: "John from My Company...",
          onTextChanged: (text) => ref.read(jobCreationProvider.notifier).updateEmailFrom(text),
        ),
        SimpleTextFieldGray(
          heading: "Subject:",
          hintText: "John from My Company...",
          onTextChanged: (text) => ref.read(jobCreationProvider.notifier).updateEmailSubject(text),
        ),
        BodyEmailTemplateEdit(
          validator: (text) {
            if (text == null || text.isEmpty) {
              return "Please enter some text";
            }
            return null;
          },
        )
      ],
    );
  }
}

class BodyEmailTemplateEdit extends ConsumerWidget {
  final String? Function(String?)? validator;

  const BodyEmailTemplateEdit({
    super.key,
    required this.validator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      enableInteractiveSelection: true,
      initialValue: ref.read(jobCreationProvider.notifier).emailBody,
      onChanged: (value) => ref.read(jobCreationProvider.notifier).updateEmailBody(value),
      maxLines: null,
      style: const TextStyle(
        letterSpacing: 0.4,
        fontSize: 16.0,
        height: 1.5,
        color: Colors.black87,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(6),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
      ),
    );
  }
}

class SimpleTextFieldGray extends StatelessWidget {
  final Function(String) onTextChanged;
  final String? heading;
  final String? hintText;

  const SimpleTextFieldGray({super.key, required this.onTextChanged, this.hintText, this.heading});

  @override
  Widget build(BuildContext context) {
    Widget returnTextfield() {
      return SizedBox(
        width: 250,
        height: 45,
        child: TextField(
          
            onChanged: onTextChanged,
            decoration: InputDecoration(
              filled: true,
              hintText: hintText,
              hintStyle: ktextFieldHintStyle,
              fillColor: const Color(0xFFEFEFEF),
              focusColor: const Color(0xFFEFEFEF),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            )),
      );
    }

    if (heading != null) {
      return Row(
        children: [
          SizedBox(width: 100, child: Text(heading!, style: ktextFieldHeadingStyle)),
          returnTextfield(),
        ],
      );
    }
    return returnTextfield();
  }
}

class JobSearchDynamicSection extends ConsumerWidget {
  const JobSearchDynamicSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(jobCreationProvider).newJobSearchSection == NewJobSearchSection.chooseBenchmarks) {
      return BenchmarksWidget();
    } else {
      return EmailTemplateWidget();
    }
  }
}
