import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:platform_front/components/dashboard/home/Sections/participation_widget.dart';
import 'package:platform_front/components/dashboard/home/Sections/benchmarkWidget.dart';
import 'package:platform_front/components/dashboard/home/Sections/currentActionAreaWidget.dart';
import 'package:platform_front/components/dashboard/home/Sections/nextAssessmentWidget.dart';
import 'package:platform_front/components/dashboard/home/Sections/topOppertunitiesWidget/TopOppertunitiesWidget.dart';
import 'package:platform_front/components/global/blurOverlay.dart';
import 'package:platform_front/components/global/loading_overlay.dart';
import 'package:platform_front/components/global/no_data_pop_up.dart';
import 'package:platform_front/components/global/top_action_banner.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';

class HomeScreenBody extends ConsumerWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool blurWidgets = ref.watch(metricsDataProvider).participationBelow30;

    return OverlayWidget(
      loadingProvider: ref.watch(metricsDataProvider).loading,
      showChild: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            child: Stack(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 1008,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Home",
                          style: kH1TextStyle,
                        ),
                        if (!ref.read(metricsDataProvider).noSurveyData) ActiveAssessmentTextWidget()
                      ],
                    ),
                  ),
                  if (ref.watch(metricsDataProvider).noSurveyData || ref.watch(metricsDataProvider).participationBelow30 || ref.watch(metricsDataProvider).between30And70) TopActionBanner(),
                  const SizedBox(height: 16),
                  Row(children: [
                    const SizedBox(
                      width: 6,
                    ),
                    BlurOverlay(
                      child: BenchmarkWidget(),
                      blur: blurWidgets,
                    ),
                    const SizedBox(width: 32),
                    ParticipationWidget(),
                  ]),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: 1000,
                    height: 270,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 6,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BlurOverlay(
                              child: CurrentActionAreaWidget(),
                              blur: blurWidgets,
                            ),
                            if(!ref.watch(metricsDataProvider).noSurveyData) BlurOverlay(
                              blur: blurWidgets,
                              child: NextAssessmentWidget(
                                nextAssessmentData: '24 Feb 2025',
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 32,
                        ),
                        BlurOverlay(
                          child: TopOppertunitiesWidget(),
                          blur: blurWidgets,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  )
                ],
              ),
              NoDataPopUp()
            ]),
          ),
        ),
      ),
    );
  }
}

class ActiveAssessmentTextWidget extends ConsumerWidget {
  const ActiveAssessmentTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> processSurveyDate(String dateString) {
      try {
        // Split into date and time parts
        List<String> parts = dateString.split('T');
        if (parts.length != 2) {
          // If we can't split properly, try to parse the string directly
          throw FormatException('Invalid date format');
        }

        String datePart = parts[0]; // This is already in YYYY-MM-DD format
        String timePart = parts[1].replaceAll('-', ':'); // Convert time separators

        // Combine date and time
        String normalizedDate = '$datePart $timePart';

        // Parse the normalized date string
        DateTime dateObj = DateTime.parse(normalizedDate);

        // Format to "17 Feb 2025"
        String formatted = DateFormat('dd MMM yyyy').format(dateObj);

        // Calculate date 4 months in future
        DateTime futureDate = DateTime(
          dateObj.year,
          dateObj.month + 4,
          dateObj.day,
          dateObj.hour,
          dateObj.minute,
          dateObj.second,
        );
        String futureFormatted = DateFormat('dd MMM yyyy').format(futureDate);

        return [formatted, futureFormatted];
      } catch (e) {
        // Handle parsing errors by returning a default or current date
        DateTime now = DateTime.now();
        String formatted = DateFormat('dd MMM yyyy').format(now);
        DateTime futureDate = DateTime(now.year, now.month + 4, now.day);
        String futureFormatted = DateFormat('dd MMM yyyy').format(futureDate);

        print('Error processing date: $dateString'); // For debugging
        return [formatted, futureFormatted];
      }
    }

    String formatedSurveyDate = processSurveyDate(ref.watch(metricsDataProvider).surveyMetric.surveyName)[0];
    return Text(
      formatedSurveyDate,
      style: kH5PoppinsLight,
    );
  }
}
