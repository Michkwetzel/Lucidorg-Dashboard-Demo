import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/providers.dart';

class NoDataPopUp extends ConsumerWidget {
  const NoDataPopUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Assuming you have a provider that returns bool
    // Replace this with your actual provider
    final metricDataProvider = ref.read(metricsDataProvider.notifier);

    if (metricDataProvider.getShowPopUp() && metricDataProvider.getNoSurveyData()) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Welcome to LucidOrg'),
              content: const Text('Instructions:\n1. Create and send out an Assessment.\n2. Wait until participation rate is above 70\n3. View results'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    metricDataProvider.hidePopUp();
                  },
                  child: const Text('Dismiss'),
                ),
              ],
            );
          },
        );
      });
    }
    return Container();
  }
}
