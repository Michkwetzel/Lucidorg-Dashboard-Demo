enum SelectionButtonType { token, guest, employee, none }

enum EmailListRadioButtonType { ceo, cSuite, employee }

enum NavBarButtonType { createAssessment, companyInfo, logOut, home, results, impact, theFix, closeMenu }

enum Permission { exec, employee, guest, error }

enum Diffsize { H1, H2, H3, H4}

enum ResultSection { overview, areaScore, diffMatrix, foundations }

enum ImpactSection { orgImpact, financial, scoreOverTime, diffOverTime }

enum MainArea { alignment, people, process, leadership }
enum Indicator {
  purposeDriven('purposeDriven', 'Purpose Driven Organization'),
  growthAlign('growthAlign', 'Growth Alignment'),
  orgAlign('alignedOrgStruct', 'Organizational Alignment'),
  collabProcesses('collabProcess', 'Collaborative Processes'),
  collabKPI('collabKPIs', 'Collaborative KPIs'),
  alignedTech('alignedTech', 'Aligned Tech Stack'),
  crossFuncComms('crossComms', 'Cross-Functional Communications'),
  empoweredLeadership('empoweredLeadership', 'Empowered Leadership'),
  engagedCommunity('engagedCommunity', 'Engaged Community'),
  meetingEfficacy('meetingEfficacy', 'Meeting Efficacy'),
  crossFuncAcc('crossAcc', 'Cross-Functional Accountability');

  final String value;
  final String heading;
  
  const Indicator(this.value, this.heading);

  // If you still need the asString getter for backward compatibility
  String get asString => value;
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
