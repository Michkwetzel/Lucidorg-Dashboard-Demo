// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:platform_front/components/buttons/CallToActionButton.dart';
import 'package:platform_front/components/textFields/textfieldGray.dart';
import 'package:platform_front/config/constants.dart';

class CompanyInfoBody extends StatelessWidget {
  CompanyInfoBody({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Add this to align columns at the top
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
            mainAxisSize: MainAxisSize.min, // Add th
            children: [
              Text(
                'Company Info',
                style: kH1TextStyle,
              ),
              Text('Company Name'),
              TextfieldGray(height: 50, controller: controller),
              Text('Num of Employees'),
              StyledDropdown(items: ['1-10', '10-50', '50-100', '100-200', '200+']),
              Text('Stage of Funding'),
              StyledDropdown(
                items: ['Pre-seed', 'Seed Funding', 'Series A', 'Series B', 'Series C and Beyond'],
              ),
              Text('Industry'),
              StyledDropdown(items: [
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
              ]),
              Text('Region'),
              StyledDropdown(items: [
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
              ]),
              SizedBox(height: 32,),
              Align(
                alignment: Alignment.centerRight,
                child: CallToActionButton(onPressed: () {}, buttonText: "Save"))
            ],
          ),
        ),
      ],
    );
  }
}

class StyledDropdown extends StatefulWidget {
  final List<String> items;
  const StyledDropdown({super.key, required this.items});

  @override
  State<StyledDropdown> createState() => _StyledDropdownState();
}

class _StyledDropdownState extends State<StyledDropdown> {
  late String selectedValue = widget.items[0];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButton<String>(
        value: selectedValue,
        isExpanded: true,
        underline: Container(), // Removes the default underline
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        icon: const Icon(Icons.arrow_drop_down),
        onChanged: (String? value) {
          setState(() {
            selectedValue = value!;
          });
        },
        items: widget.items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
