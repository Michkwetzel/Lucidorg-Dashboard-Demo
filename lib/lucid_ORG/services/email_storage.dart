import 'dart:html' as html;
import 'dart:convert';

class EmailStorage {
  static const String KEY_CEO_EMAILS = 'ceo_email_list';
  static const String KEY_CSUITE_EMAILS = 'csuite_email_list';
  static const String KEY_EMPLOYEE_EMAILS = 'employee_email_list';

  static String combineUserIDandKey(String userID, String key) {
    return '$userID-$key';
  }

  // Save emails to localStorage
  static void saveEmails(String key, List<String> emails, {required String? userID}) {
    if (userID == null) {
      return;
    }
    final emailsJson = jsonEncode(emails);
    html.window.localStorage[combineUserIDandKey(userID, key)] = emailsJson;
  }

  // Load emails from localStorage
  static List<String> loadEmails(String key, {required String? userID}) {
    if (userID == null) {
      return [];
    }
    final emailsJson = html.window.localStorage[combineUserIDandKey(userID, key)];
    if (emailsJson == null || emailsJson.isEmpty) {
      return [];
    }
    return List<String>.from(jsonDecode(emailsJson));
  }

  // Clear emails after assessment is sent
  static void clearAllEmails({required String? userID}) {
    if (userID == null) {
      return;
    }
    html.window.localStorage.remove(combineUserIDandKey(userID, KEY_CEO_EMAILS));
    html.window.localStorage.remove(combineUserIDandKey(userID, KEY_CSUITE_EMAILS));
    html.window.localStorage.remove(combineUserIDandKey(userID, KEY_EMPLOYEE_EMAILS));
  }

  static void clearDepartmentEmails(String key, {required String? userID}) {
    if (userID == null) {
      return;
    }
    html.window.localStorage.remove(combineUserIDandKey(userID, key));
  }
}
