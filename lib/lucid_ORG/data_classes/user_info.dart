import 'package:platform_front/core_config/enums.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class UserInfoObj {
  final String? email;
  final String? companyUID;
  final String? userUID;
  final Permission? permission;

  const UserInfoObj({this.email, this.companyUID, this.userUID, this.permission});
}
