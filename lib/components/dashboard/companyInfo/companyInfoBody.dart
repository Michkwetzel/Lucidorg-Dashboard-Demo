// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/components/buttons/CallToActionButton.dart';
import 'package:platform_front/components/dashboard/companyInfo/customTextFieldForm.dart';
import 'package:platform_front/components/dashboard/companyInfo/styledDropdown.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';
import 'package:platform_front/services/microServices/snackBarService.dart';

class CompanyInfoBody extends ConsumerStatefulWidget {
  const CompanyInfoBody({super.key});

  @override
  ConsumerState<CompanyInfoBody> createState() => _CompanyInfoBodyState();
}

class _CompanyInfoBodyState extends ConsumerState<CompanyInfoBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController companyNameController = TextEditingController();
  late String numEmployees;
  late String fundingStage;
  late String industry;
  late String region;

  @override
  void initState() {
    super.initState();
    Map<String, String> companyInfo = ref.read(companyInfoProvider);
    companyNameController.text = companyInfo['companyName'] ?? '';
    numEmployees = companyInfo['numberOfEmployees'] ?? '1-50';
    fundingStage = companyInfo['fundingStage'] ?? 'Pre-seed';
    industry = companyInfo['industry'] ?? 'Technology & Software';
    region = companyInfo['region'] ?? 'North America';
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> companyInfo = ref.read(companyInfoProvider);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Company Info',
            style: kH1TextStyle,
          ),
          SizedBox(
            height: 16,
          ),
          Text('Company Name'),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 250),
            child: CustomTextFieldForm(ref: ref, companyNameController: companyNameController),
          ),
          SizedBox(
            height: 16,
          ),
          Text('Num of Employees'),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 120),
            child: StyledDropdown(
              initalValue: companyInfo['numberOfEmployees'] ?? '1-50',
              items: const ['1-50', '50-100', '100-200', '200+'],
              onChanged: (value) => setState(() => numEmployees = value),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text('Stage of Funding'),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 250),
            child: StyledDropdown(
              initalValue: companyInfo['fundingStage'] ?? 'Pre-seed',
              items: const ['Pre-seed', 'Seed Funding', 'Series A', 'Series B', 'Series C and Beyond'],
              onChanged: (value) => setState(() => fundingStage = value),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text('Industry'),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 250),
            child: StyledDropdown(
              initalValue: companyInfo['industry'] ?? 'Technology & Software',
              items: const [
                'Technology & Software',
                'Healthcare & Medical',
                'Financial Services',
                'Manufacturing',
                'Retail & E-commerce',
                'Education',
                'Real Estate',
                'Professional Services',
                'Entertainment & Media',
                'Food & Beverage',
                'Construction',
                'Transportation & Logistics',
                'Agriculture',
                'Energy & Utilities',
                'Telecommunications'
              ],
              onChanged: (value) => setState(() => industry = value),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text('Region'),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 250),
            child: StyledDropdown(
              initalValue: companyInfo['region'] ?? 'North America',
              items: const [
                'North America',
                'Europe',
                'Asia Pacific',
                'Latin America',
                'Middle East & Africa',
                'South Asia',
                'Southeast Asia',
                'East Asia',
                'Oceania',
                'Caribbean',
                'Central America',
                'Eastern Europe',
                'Western Europe',
                'Northern Africa',
                'Sub-Saharan Africa'
              ],
              onChanged: (value) => setState(() => region = value),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 250),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: CallToActionButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final Map<String, String> formData = {
                            'companyName': companyNameController.text,
                            'numEmployees': numEmployees,
                            'fundingStage': fundingStage,
                            'industry': industry,
                            'region': region,
                          };
                          try {
                            await ref.read(companyInfoProvider.notifier).saveCompanyInfo(formData);
                            SnackBarService.showMessage("Company info successfully saved", Colors.green);
                          } on Exception catch (e) {
                            SnackBarService.showMessage("Error whilst saving companyInfo", Colors.red);
                          }
                        }
                      },
                      buttonText: "Save")))
        ],
      ),
    );
  }
}
