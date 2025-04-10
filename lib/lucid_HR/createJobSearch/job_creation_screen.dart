import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/global_components/buttons/primaryButton.dart';
import 'package:platform_front/global_components/buttons/secondaryButton.dart';
import 'package:platform_front/global_components/gray_divider.dart';
import 'package:platform_front/lucid_HR/config/enums.dart';
import 'package:platform_front/lucid_HR/config/providers.dart';
import 'package:platform_front/lucid_HR/createJobSearch/components/add_emails_widget_hr.dart';
import 'package:platform_front/lucid_ORG/components/company_info/customTextFieldForm.dart';
import 'package:platform_front/lucid_ORG/components/create_assessment/emailList/emailListView/emailCard.dart';

class JobCreationScreen extends StatelessWidget {
  const JobCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24,
      children: [
        Text(
          "Create Job Search",
          style: kH1TextStyle,
        ),
        Row(
          children: [
            Column(
              spacing: 24,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputTitleWidget(textEditingController: textEditingController),
                Emaillistbody(),
              ],
            ),
          ],
        )
      ],
    );
  }
}

class InputTitleWidget extends StatelessWidget {
  final TextEditingController textEditingController;

  const InputTitleWidget({super.key, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Title",
          style: kH2TextStyle,
        ),
        SizedBox(
          width: 350,
          height: 50,
          child: CustomTextFieldForm(
            hintText: "Please Enter Job Title...",
            textEditController: textEditingController,
          ),
        )
      ],
    );
  }
}

class Emaillistbody extends ConsumerWidget {
  const Emaillistbody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 500,
      width: 350,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF555353), width: 0.7),
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Padding(padding: const EdgeInsets.all(24.0), child: ref.watch(jobCreationProvider).display == EmailListDisplay.view ? EmailListViewHR() : AddEmailsWidgetHR()),
    );
  }
}

class EmailListViewHR extends ConsumerWidget {
  const EmailListViewHR({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email List',
          style: kH2TextStyle,
        ),
        SizedBox(height: 12),
        GrayDivider(color: Colors.black, thickness: 1),
        SizedBox(height: 4),
        Expanded(child: EmailListWidget()),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Secondarybutton(onPressed: () => ref.read(jobCreationProvider.notifier).clearEmails(), buttonText: 'Clear'),
            Primarybutton(onPressed: () => ref.read(jobCreationProvider.notifier).changeToAddEmailsDisplay(), buttonText: 'Add Emails'),
          ],
        )
      ],
    );
  }
}

class EmailListWidget extends ConsumerWidget {
  const EmailListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> emailList = ref.watch(jobCreationProvider).emailList;

    return ListView.builder(
      itemCount: emailList.length,
      itemBuilder: (context, index) {
        return EmailCard(
          emailText: emailList[index],
          index: index,
          onDelete: () => ref.read(jobCreationProvider.notifier).removeEmail(index),
        );
      },
    );
  }
}
