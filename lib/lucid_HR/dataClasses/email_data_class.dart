import 'package:platform_front/lucid_HR/config/enums_hr.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class EmailDataClass {
  final String emailAddress;
  final Map<Indicator, double> benchmarks;
  final ApplicationStatus applicationStatus;
  final FollowUpStatus followUpStatus;
  final bool finished;
  final String id;

  EmailDataClass({
    required this.emailAddress,
    required this.benchmarks,
    this.applicationStatus = ApplicationStatus.none,
    this.followUpStatus = FollowUpStatus.none,
    required this.finished,
    required this.id,
  });

  factory EmailDataClass.empty() {
    return EmailDataClass(
      emailAddress: '',
      benchmarks: {},
      finished: false,
      id: '',
    );
  }

  factory EmailDataClass.fromMap(Map<String, dynamic> map, String id) {
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

    FollowUpStatus getFollowUpStatus(String status) {
      switch (status) {
        case 'none':
          return FollowUpStatus.none;
        case 'acceptedEmailSent':
          return FollowUpStatus.acceptedEmailSent;
        case 'deniedEmailSent':
          return FollowUpStatus.deniedEmailSent;
        default:
          return FollowUpStatus.none;
      }
    }

    ApplicationStatus getApplicationStatus(String status) {
      switch (status) {
        case 'none':
          return ApplicationStatus.none;
        case 'accepted':
          return ApplicationStatus.accepted;
        case 'denied':
          return ApplicationStatus.denied;
        default:
          return ApplicationStatus.none;
      }
    }

    return EmailDataClass(
      emailAddress: map['email'] ?? '',
      benchmarks: map['finished'] ? convertToBenchmarkMap(map['benchmarks']) : {},
      finished: map['finished'] ?? false,
      followUpStatus: getFollowUpStatus(map['followUpStatus'] ?? 'none'),
      applicationStatus: getApplicationStatus(map['applicationStatus'] ?? 'none'),
      id: id,
    );
  }
}
