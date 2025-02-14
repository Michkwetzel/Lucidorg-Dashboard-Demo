enum SelectionButtonType { token, guest, employee, none }

enum EmailListRadioButtonType { ceo, cSuite, employee }

enum NavBarButtonType { createAssessment, companyInfo, logOut, home, results, impact, theFix, closeMenu }

enum Permission { exec, employee, guest, error }

enum Diffsize { H1, H2, H3, H4 }

enum ResultSection { overview, areaScore, diffMatrix, foundations }

enum ImpactSection { orgImpact, financial, scoreOverTime, diffOverTime }

enum MainArea { alignment, people, process, leadership }

// This is technically not correct. All of these are not indicators. but it works super well.
enum Indicator {
  purposeDriven,
  growthAlign,
  orgAlign,
  collabProcesses,
  collabKPIs,
  alignedTech,
  crossFuncComms,
  empoweredLeadership,
  engagedCommunity,
  meetingEfficacy,
  crossFuncAcc,
  companyIndex,
  workforce,
  operations,
  general,
  align,
  process,
  leadership,
  people
}

List<Indicator> justIndicators() {
  return [
    Indicator.companyIndex,
    Indicator.orgAlign,
    Indicator.growthAlign,
    Indicator.collabKPIs,
    Indicator.engagedCommunity,
    Indicator.crossFuncComms,
    Indicator.crossFuncAcc,
    Indicator.alignedTech,
    Indicator.collabProcesses,
    Indicator.meetingEfficacy,
    Indicator.purposeDriven,
    Indicator.empoweredLeadership,
  ];
}

extension IndicatorDescription on Indicator {
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
      case Indicator.collabKPIs:
        return "Collaborative KPIs";
      case Indicator.alignedTech:
        return "Aligned Technology";
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
      case Indicator.companyIndex:
        return "Index";
      case Indicator.workforce:
        return "Workforce";
      case Indicator.operations:
        return "Operations";
      default:
        return "Not Indicator";
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
