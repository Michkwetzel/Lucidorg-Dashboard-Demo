import 'package:platform_front/config/enums.dart';

class IndicatorData {
  final String heading;
  final String impactText;
  final Map<ScoreRange, Map<String, String>> scoreTexts;
  final Map<DiffRange, String> diffTexts;

  IndicatorData({
    required this.heading,
    required this.impactText,
    required this.scoreTexts,
    required this.diffTexts,
  });

  String getScoreTextHeading(double score) {
    if (score < 40) return scoreTexts[ScoreRange.low]!['heading']!;
    if (score < 50) return scoreTexts[ScoreRange.moderate]!['heading']!;
    if (score < 60) return scoreTexts[ScoreRange.good]!['heading']!;
    if (score < 70) return scoreTexts[ScoreRange.excellent]!['heading']!;
    return scoreTexts[ScoreRange.perfect]!['heading']!;
  }

  String getScoreTextBody(double score) {
    if (score < 40) return scoreTexts[ScoreRange.low]!['body']!;
    if (score < 50) return scoreTexts[ScoreRange.moderate]!['body']!;
    if (score < 70) return scoreTexts[ScoreRange.excellent]!['body']!;
    return scoreTexts[ScoreRange.perfect]!['body']!;
  }

  String getDiffText(double diff) {
    if (diff < 10) return diffTexts[DiffRange.minimal]!;
    if (diff < 20) return diffTexts[DiffRange.moderate]!;
    if (diff < 30) return diffTexts[DiffRange.high]!;
    return diffTexts[DiffRange.extreme]!;
  }

  String getImpactText() {
    return impactText;
  }

  String getHeading() {
    return heading;
  }
}
