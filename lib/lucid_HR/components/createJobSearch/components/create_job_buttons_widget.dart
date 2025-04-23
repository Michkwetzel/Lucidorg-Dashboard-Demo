import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:platform_front/core_config/constants.dart';
import 'package:platform_front/global_components/buttons/CallToActionButton.dart';
import 'package:platform_front/global_components/buttons/secondaryButton.dart';
import 'package:platform_front/global_components/loading_overlay/loading_dialogue.dart';
import 'package:platform_front/lucid_HR/config/enums_hr.dart';
import 'package:platform_front/lucid_HR/config/providers_hr.dart';
import 'package:platform_front/lucid_ORG/config/providers_org.dart';
import 'package:platform_front/services/microServices/snackBarService.dart';

class CreateJobButtonsWidget extends ConsumerWidget {
  CreateJobButtonsWidget({super.key});

  final Logger logger = Logger('CreateJobButtonsWidget');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(jobCreationProvider).newJobSearchSection == NewJobSearchSection.chooseBenchmarks) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CallToActionButton(
            onPressed: () => ref.read(jobCreationProvider.notifier).onNextClicked(),
            buttonText: "Next",
          ),
        ],
      );
    } else {
      return Row(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Secondarybutton(
            onPressed: () => ref.read(jobCreationProvider.notifier).onBackClicked(),
            buttonText: "Back",
          ),
          CallToActionButton(
            onPressed: () async {
              if (ref.read(jobCreationProvider.notifier).validateAllData()) {
                try {
                  await LoadingDialog.showDuringAsync(
                    context: context,
                    asyncOperation: () => ref.read(googlefunctionserviceProvider.notifier).createNewJobSearch(
                          ref.read(jobCreationProvider.notifier).getAllData(),
                        ),
                  );
                  logger.info("Successfully Created Job Search");
                  SnackBarService.showMessage("Successfully Created Job Search", Colors.green);
                } on Exception catch (e) {
                  logger.warning("Error Creating Job Search. Error: $e");
                  SnackBarService.showMessage("Error Creating Job Search", Colors.red);
                }
              }
            },
            buttonText: "Create Job Search",
          )
        ],
      );
    }
  }
}
