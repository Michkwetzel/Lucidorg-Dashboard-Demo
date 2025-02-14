import 'package:platform_front/config/enums.dart';

class UserInfoObj {
  final String? email;
  final String? companyUID;
  final String? userUID;
  final Permission? permission;

  const UserInfoObj({this.email, this.companyUID, this.userUID, this.permission});
}
