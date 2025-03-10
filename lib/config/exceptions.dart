class SurveyException implements Exception {
  final String message;
  final String title;

  SurveyException(this.message, this.title);

  @override
  String toString() => message;
}

class CompanyNotFoundException extends SurveyException {
  CompanyNotFoundException() : super('Incorrect Assessment link.', 'Invalid Company');
}

class NoActiveSurveyException extends SurveyException {
  NoActiveSurveyException() : super('Incorrect Assessment link.', 'No Active Survey');
}
