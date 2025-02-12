// // ignore_for_file: prefer_const_constructors

import 'package:platform_front/components/dashboard/impact/side_bar/org_impact/data_class/temp/indicator_data_temp.dart';
import 'package:platform_front/components/dashboard/impact/side_bar/org_impact/data_class/temp/main_area_data.dart';
import 'package:platform_front/config/enums.dart';

class ImpactAreaData {
  static final mainAreas = {
    MainArea.alignment: MainAreaData(
      title: 'Alignment',
      impactAreas: [
        IndicatorDataTemp(
          heading: 'Growth Alignment:',
          body: 'Aligned growth vision and milestone plan (1,5,10 yrs)',
          impactValue: 1,
        ),
        IndicatorDataTemp(
          heading: 'Collaborative KPIs:',
          body: 'Determine 3-5 collaborative KPI. Define decision making, responsibility, work streams and reporting',
          impactValue: 2,
        ),
      ],
    ),
    MainArea.people: MainAreaData(title: 'People', impactAreas: [
      IndicatorDataTemp(
        heading: 'Cross-Functional Communication',
        body: 'Develop a plan to ensure 360 degrees communication across the org',
        impactValue: 1,
      ),
    ]),
    MainArea.process: MainAreaData(title: 'Process', impactAreas: [
      IndicatorDataTemp(
        heading: 'Meeting Efficacy',
        body: 'Streamline meeting processes agendas, attendees and number of meetings taking place',
        impactValue: 1,
      ),
    ]),
    MainArea.leadership: MainAreaData(
      title: 'Leadership',
      impactAreas: [
        IndicatorDataTemp(
          heading: 'Purpose Driven:',
          body: 'Purpose driven culture where the purpose becomes apart of both the internal and eternal stakeholders during the onboarding process',
          impactValue: 1,
        ),
      ],
    ),
  };
}
