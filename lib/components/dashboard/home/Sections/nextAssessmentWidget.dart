import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/constants.dart';
import 'package:intl/intl.dart';
import 'package:platform_front/config/providers.dart';

class NextAssessmentWidget extends ConsumerWidget {
  final String nextAssessmentData;

  const NextAssessmentWidget({
    required this.nextAssessmentData,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> processSurveyDate(String dateString) {
      try {
        // Split into date and time parts
        List<String> parts = dateString.split('T');
        if (parts.length != 2) {
          // If we can't split properly, try to parse the string directly
          throw FormatException('Invalid date format');
        }

        String datePart = parts[0]; // This is already in YYYY-MM-DD format
        String timePart = parts[1].replaceAll('-', ':'); // Convert time separators

        // Combine date and time
        String normalizedDate = '$datePart $timePart';

        // Parse the normalized date string
        DateTime dateObj = DateTime.parse(normalizedDate);

        // Format to "17 Feb 2025"
        String formatted = DateFormat('dd MMM yyyy').format(dateObj);

        // Calculate date 4 months in future
        DateTime futureDate = DateTime(
          dateObj.year,
          dateObj.month + 4,
          dateObj.day,
          dateObj.hour,
          dateObj.minute,
          dateObj.second,
        );
        String futureFormatted = DateFormat('dd MMM yyyy').format(futureDate);

        return [formatted, futureFormatted];
      } catch (e) {
        // Handle parsing errors by returning a default or current date
        DateTime now = DateTime.now();
        String formatted = DateFormat('dd MMM yyyy').format(now);
        DateTime futureDate = DateTime(now.year, now.month + 4, now.day);
        String futureFormatted = DateFormat('dd MMM yyyy').format(futureDate);

        print('Error processing date: $dateString'); // For debugging
        return [formatted, futureFormatted];
      }
    }

    String nextAssessmentDate = processSurveyDate(ref.read(metricsDataProvider).surveyMetric.surveyName)[1];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(color: Color(0xFFE0E0E0), borderRadius: BorderRadius.circular(12)),
        child: Text(
          'Next Assessment: $nextAssessmentDate',
          style: kH5PoppinsRegular,
        ),
      ),
    );
  }
}
