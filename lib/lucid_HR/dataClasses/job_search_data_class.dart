import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:platform_front/lucid_HR/dataClasses/email_data_class.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class JobSearchDataClass {
  final String title;
  final String id;
  final int sent;
  final int submitted;
  final Timestamp dateCreated;
  final Map<Indicator, double> benchmark;
  final List<String> allEmailsString;
  final List<EmailDataClass> allEmailsData;

  JobSearchDataClass({
    required this.id,
    required this.title,
    required this.sent,
    required this.submitted,
    required this.dateCreated,
    required this.benchmark,
    required this.allEmailsString,
    required this.allEmailsData,
  });

  factory JobSearchDataClass.empty() {
    return JobSearchDataClass(
      id: '',
      title: '',
      sent: 0,
      submitted: 0,
      dateCreated: Timestamp.now(),
      benchmark: {},
      allEmailsString: [],
      allEmailsData: [],
    );
  }

  factory JobSearchDataClass.loadMetricsFromMap(Map<String, dynamic> map, List<EmailDataClass> emailData, String id) {
    // This is initally first loaded from jobSearchMetrics_HR
    // Then afterwards the email Data gets loaded

    Map<Indicator, double> convertToBenchmarkMap(Map<String, dynamic> rawMap) {
      Map<Indicator, double> resultMap = {};

      for (Indicator indicator in Indicator.values) {
        String enumString = indicator.toString();
        List<String> parts = enumString.split('.');
        String key = parts.last;
        dynamic rawValue = rawMap[key];
        if (rawValue != null) {
          double value = rawValue.toDouble();
          if (value != 0.0) {
            resultMap[indicator] = value;
          }
        }
      }

      return resultMap;
    }

    return JobSearchDataClass(
      title: map['title'],
      sent: map['numSent'] ?? 0,
      submitted: map['numSubmitted'] ?? 0,
      dateCreated: map['dateCreated'],
      benchmark: convertToBenchmarkMap(map['benchmarks']),
      allEmailsString: List.from(map['allEmails'] ?? []),
      allEmailsData: emailData,
      id: id,
    );
  }
}
