import 'package:flutter/widgets.dart';
import 'package:platform_front/components/dashboard/new_Home/benchmark_widget_new.dart';
import 'package:platform_front/components/dashboard/new_Home/participation_widget_new.dart';

class HomeSB extends StatelessWidget {
  const HomeSB({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 32,
      children: [
        ParticipationWidgetNew(),
        BenchmarkWidgetNew(),
      ],
    );
  }
}
