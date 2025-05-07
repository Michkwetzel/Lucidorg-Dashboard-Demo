import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/global_components/gray_divider.dart';
import 'package:platform_front/lucid_ORG/components/focus/main_view/action_step_1/focus_area_row.dart';
import 'package:platform_front/lucid_ORG/components/focus/main_view/action_step_1/pyramid_widget.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/lucid_ORG/notifiers/surveyMetrics/metrics_data.dart';

class ActionStep1Body extends StatelessWidget {
  const ActionStep1Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        CustomDivider(),
        SizedBox(height: 16),
        Text('Solve the widest differentiation from the top down', style: kH5PoppinsLight),
        Stack(
          children: [
            Row(
              children: [
                SizedBox(width: 60),
                Padding(
                  padding: const EdgeInsets.only(bottom: 70),
                  child: FocusAreasWidget(),
                ),
                SizedBox(width: 40),
                PyramidWidget(),
              ],
            ),
            Positioned(
              left: 620,
              top: 20,
              child: SizedBox(
                width: 200,
                child: Row(
                  children: [
                    Flexible(
                      child: Column(
                        spacing: 8,
                        children: [
                          Text(
                            'The indicators are stacked in a pyramid style with descending Priority',
                            style: kH6PoppinsLight.copyWith(fontSize: 16),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/trianlge.svg',
                                width: 22,
                                height: 22,
                                colorFilter: ColorFilter.mode(Color(0xFF3F3F3F), BlendMode.srcIn),
                              ),
                              Text(
                                '= Differentiation',
                                style: kH6PoppinsLight.copyWith(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 30,
                      child: CustomPaint(
                        painter: ArrowPainter(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        InfoDropDownWidget(),
      ],
    );
  }
}

class InfoDropDownWidget extends StatefulWidget {
  const InfoDropDownWidget({
    super.key,
  });

  @override
  State<InfoDropDownWidget> createState() => _InfoDropDownWidgetState();
}

class _InfoDropDownWidgetState extends State<InfoDropDownWidget> {
  bool isExpanded1 = false;
  bool isExpanded2 = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => isExpanded1 = !isExpanded1),
          child: Row(
            children: [
              Text('Why top down?', style: kH5PoppinsLight),
              Icon(
                Icons.arrow_drop_down,
              ),
            ],
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: isExpanded1 ? 100 : 0,
        ),
        SizedBox(height: 16),
        GestureDetector(
          onTap: () => setState(() => isExpanded2 = !isExpanded2),
          child: Row(
            children: [
              Text('Why Differentation first?', style: kH5PoppinsLight),
              Icon(
                Icons.arrow_drop_down,
              ),
            ],
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: isExpanded2 ? 100 : 0,
        ),
      ],
    );
  }
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    // Draw the arrow shaft
    canvas.drawRect(
      Rect.fromLTWH(size.width / 2 - 2, 0, 4, size.height - 10),
      paint,
    );

    // Draw the arrow head
    final Path path = Path();
    path.moveTo(0, size.height - 10);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, size.height - 10);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class FocusAreasWidget extends ConsumerWidget {
  const FocusAreasWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SurveyMetric surveyMetric = ref.watch(metricsDataProvider).surveyMetric;

    //Get higest diff indicators and display
    List<Indicator> topOppIndicators = surveyMetric.getHighestDiffIndicators(3);

    return Container(
      width: 550,
      padding: EdgeInsets.only(top: 16, right: 32, left: 32, bottom: 32),
      child: Column(
        spacing: 12,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Focus Areas',
            style: kH2PoppinsRegular,
          ),
          SizedBox(height: 6),
          FocusAreaRow(text: '1. ${topOppIndicators[0].heading}', diff: surveyMetric.diffScores[topOppIndicators[0]]!, score: surveyMetric.companyBenchmarks[topOppIndicators[0]]!),
          FocusAreaRow(text: '2. ${topOppIndicators[1].heading}', diff: surveyMetric.diffScores[topOppIndicators[1]]!, score: surveyMetric.diffScores[topOppIndicators[1]]!),
          FocusAreaRow(text: '3. ${topOppIndicators[2].heading}', diff: surveyMetric.diffScores[topOppIndicators[2]]!, score: surveyMetric.companyBenchmarks[topOppIndicators[2]]!),
        ],
      ),
    );
  }
}
