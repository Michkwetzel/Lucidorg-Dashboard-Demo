enum SelectionButtonType { token, guest, employee, none }

enum EmailListRadioButtonType { ceo, cSuite, employee }

enum NavBarButtonType { createAssessment, companyInfo, logOut, home, results, impact, theFix, closeMenu }

enum Permission { exec, employee, guest, error }

enum Diffsize { H1, H2, H3, H4 }

enum ResultSection { overview, areaScore, diffMatrix, foundations }

enum ImpactSection { orgImpact, financial, scoreOverTime, diffOverTime }

enum MainArea { alignment, people, process, leadership }

enum Indicator { purposeDriven, growthAlign, orgAlign, collabProcesses, collabKPI, alignedTech, crossFuncComms, empoweredLeadership, engagedCommunity, meetingEfficacy, crossFuncAcc }

// This is the text used in SurveyMetric data class. Ideally later switch this in SurveyMetric to be enum Indicator instead of text key
extension IndicatorDescription on Indicator {
  String get asString {
    switch (this) {
      case Indicator.meetingEfficacy:
        return "meetingEfficacy";
      case Indicator.orgAlign:
        return "alignedOrgStruct";
      case Indicator.alignedTech:
        return "alignedTech";
      case Indicator.growthAlign:
        return "growthAlign";
      case Indicator.collabKPI:
        return "collabKPIs";
      case Indicator.crossFuncAcc:
        return "crossAcc";
      case Indicator.crossFuncComms:
        return "crossComms";
      case Indicator.engagedCommunity:
        return "engagedCommunity";
      case Indicator.collabProcesses:
        return "collabProcess";
      case Indicator.purposeDriven:
        return "purposeDriven";
      case Indicator.empoweredLeadership:
        return "empoweredLeadership";
    }
  }

  String get heading {
    switch (this) {
      case Indicator.purposeDriven:
        return "Purpose Driven Organization";
      case Indicator.growthAlign:
        return "Growth Alignment";
      case Indicator.orgAlign:
        return "Organizational Alignment";
      case Indicator.collabProcesses:
        return "Collaborative Processes";
      case Indicator.collabKPI:
        return "Collaborative KPIs";
      case Indicator.alignedTech:
        return "Aligned Tech Stack";
      case Indicator.crossFuncComms:
        return "Cross-Functional Communications";
      case Indicator.empoweredLeadership:
        return "Empowered Leadership";
      case Indicator.engagedCommunity:
        return "Engaged Community";
      case Indicator.meetingEfficacy:
        return "Meeting Efficacy";
      case Indicator.crossFuncAcc:
        return "Cross-Functional Accountability";
    }
  }
}

enum Alligned { best, worst }

enum ScoresOverTime { improvement, decline }

enum ScoreRange {
  low, // < 40
  moderate, // 40-50
  good, // 50-60
  excellent, // 60-70
  perfect // 70+
}

enum DiffRange {
  minimal, // < 10
  moderate, // 10-20
  high, // 20-30
  extreme // 30+
}
