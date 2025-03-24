enum SelectionButtonType { exec, guest, employee, none }

enum EmailListRadioButtonType { ceo, cSuite, employee }

enum NavBarButtonType { createAssessment, currentAssessment, newAssessment, companyInfo, logOut, home, results, impact, theFix, closeMenu, howTo }

enum AssessmentDisplay { create, current }

// All constants given by Vandie
enum Finance { profit, cost, margin, productivity, turnover }

extension Value on Finance {
  double get b {
    switch (this) {
      case Finance.profit:
        return 0.3;
      case Finance.cost:
        return 0.3;
      case Finance.margin:
        return 0.3;
      case Finance.productivity:
        return 0.5;
      case Finance.turnover:
        return 0.5;
    }
  }

  double get c {
    switch (this) {
      case Finance.profit:
        return -0.15;
      case Finance.cost:
        return 0.15;
      case Finance.margin:
        return -0.15;
      case Finance.productivity:
        return -0.15;
      case Finance.turnover:
        return 0.15;
    }
  }

  double get d {
    switch (this) {
      case Finance.profit:
        return 3;
      case Finance.cost:
        return 3;
      case Finance.margin:
        return 3;
      case Finance.productivity:
        return 3;
      case Finance.turnover:
        return 3;
    }
  }
}

enum Permission { exec, employee, guest, error }

enum Diffsize { H1, H2, H3, H4 }

enum ResultSection { overview, areaScore, diffMatrix, foundations }

enum ImpactSection { orgImpact, financial, scoreOverTime, diffOverTime }

enum HomeSection { home, currentAssessment, newAssessment, howTo }

enum DashboardSection { home, currentAssessment, createAssessment, results, impact }

enum Pilar { alignment, people, process, leadership, none }

enum Compare { score, diff, overall }

enum Alligned { best, worst }

enum ScoresOverTime { improvement, decline }

enum Department { ceo, cSuite, staff }

extension DepartmentHeading on Department {
  String get heading {
    switch (this) {
      case Department.ceo:
        return "CEO";
      case Department.cSuite:
        return "C-Suite";
      case Department.staff:
        return "Staff";
    }
  }
}

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

extension PilarHeading on Pilar {
  String get heading {
    switch (this) {
      case Pilar.alignment:
        return "Aligment";
      case Pilar.people:
        return "People";
      case Pilar.process:
        return "Process";
      case Pilar.leadership:
        return "Leadership";
      default:
        return "None";
    }
  }
}

enum ImpactSize { small, medium, large }

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

  String get radarChartHeading {
    switch (this) {
      case Indicator.purposeDriven:
        return "Purpose\nDriven";
      case Indicator.growthAlign:
        return "Growth\nAlignment";
      case Indicator.orgAlign:
        return "Organizational\nAlignment";
      case Indicator.collabProcesses:
        return "Collaborative\nProcesses";
      case Indicator.collabKPIs:
        return "Collaborative\nKPIs";
      case Indicator.alignedTech:
        return "Aligned\nTechnology";
      case Indicator.crossFuncComms:
        return "Cross-Functional\nCommunications";
      case Indicator.empoweredLeadership:
        return "Empowered\nLeadership";
      case Indicator.engagedCommunity:
        return "Engaged\nCommunity";
      case Indicator.meetingEfficacy:
        return "Meeting\nEfficacy";
      case Indicator.crossFuncAcc:
        return "Cross-Functional\nAccountability";
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

  Pilar get pilar {
    switch (this) {
      case Indicator.purposeDriven:
        return Pilar.leadership;
      case Indicator.growthAlign:
        return Pilar.alignment;
      case Indicator.orgAlign:
        return Pilar.alignment;
      case Indicator.collabProcesses:
        return Pilar.process;
      case Indicator.collabKPIs:
        return Pilar.alignment;
      case Indicator.alignedTech:
        return Pilar.process;
      case Indicator.crossFuncComms:
        return Pilar.people;
      case Indicator.empoweredLeadership:
        return Pilar.leadership;
      case Indicator.engagedCommunity:
        return Pilar.people;
      case Indicator.meetingEfficacy:
        return Pilar.process;
      case Indicator.crossFuncAcc:
        return Pilar.people;
      default:
        return Pilar.none;
    }
  }
}
