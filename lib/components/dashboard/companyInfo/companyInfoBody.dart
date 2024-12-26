// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/components/buttons/CallToActionButton.dart';
import 'package:platform_front/components/dashboard/companyInfo/styledDropdown.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';

class CompanyInfoBody extends ConsumerStatefulWidget {
  const CompanyInfoBody({super.key});

  @override
  ConsumerState<CompanyInfoBody> createState() => _CompanyInfoBodyState();
}

class _CompanyInfoBodyState extends ConsumerState<CompanyInfoBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController companyNameController = TextEditingController();
  String numEmployees = '1-10';
  String stageFunding = 'Pre-seed';
  String industry = 'Technology & Software';
  String region = 'North America';

  @override
  Widget build(BuildContext context) {
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
            child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Company Name";
                  }
                  return null;
                },
                controller: companyNameController,
                decoration: InputDecoration(
                  filled: true,
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
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.red, width: 1),
                  ),
                )),
          ),
          SizedBox(
            height: 16,
          ),
          Text('Num of Employees'),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 100),
            child: StyledDropdown(
              items: const ['1-10', '10-50', '50-100', '100-200', '200+'],
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
              items: const ['Pre-seed', 'Seed Funding', 'Series A', 'Series B', 'Series C and Beyond'],
              onChanged: (value) => setState(() => stageFunding = value),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text('Industry'),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 250),
            child: StyledDropdown(
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final Map<String, String> formData = {
                            'companyName': companyNameController.text,
                            'numberOfEmployees': numEmployees,
                            'fundingStage': stageFunding,
                            'industry': industry,
                            'region': region,
                          };
                          ref.read(companyInfoProvider.notifier).saveCompanyInfo(formData);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Company info successfully saved'),
                              backgroundColor: Colors.blue,
                            ),
                          );
                        }
                      },
                      buttonText: "Save")))
        ],
      ),
    );
  }
}
