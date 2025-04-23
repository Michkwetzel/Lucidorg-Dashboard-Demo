import 'package:flutter/material.dart';
import 'package:platform_front/lucid_HR/components/createJobSearch/components/benchmark_widgets/benchmark_slider_widget.dart';
import 'package:platform_front/lucid_HR/components/global_components/heading_and_divider.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class BenchmarksWidget extends StatelessWidget {
  const BenchmarksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadingAndDivider(
          heading: "Benchmarks",
        ),
        BenchmarkSliderWidget(
          extraText:
              "Alignment scores show how well a candidate fits the company’s structure, goals, and collaboration style. lower scores fit structured roles, mid-range balances flexibility, and higher scores suit autonomous environments.",
          heading: "Alignment",
          indicator: Indicator.align,
        ),
        BenchmarkSliderWidget(
          extraText:
              "People scores measure how a candidate engages with company culture, teamwork, and accountability—lower scores fit structured, role-defined teams, mid-range balances collaboration and autonomy, and higher scores suit highly engaged, self-driven environments",
          heading: "People",
          indicator: Indicator.people,
        ),
        BenchmarkSliderWidget(
          extraText:
              "Process scores assess how a candidate adapts to systems, workflows, and efficiency—lower scores fit structured, process-driven roles, mid-range balances adherence and adaptability, and higher scores suit fast-moving, flexible environments",
          heading: "Process",
          indicator: Indicator.process,
        ),
        BenchmarkSliderWidget(
          extraText:
              "Leadership scores reflect decision-making, initiative, and influence—lower scores fit structured, top-down environments, mid-range balances autonomy with guidance, and higher scores suit self-led, empowered leadership roles.",
          heading: "Leadership",
          indicator: Indicator.leadership,
        ),
      ],
    );
  }
}
