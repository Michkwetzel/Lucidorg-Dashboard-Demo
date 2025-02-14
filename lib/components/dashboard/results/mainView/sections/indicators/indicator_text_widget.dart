import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/enums.dart';
import 'package:platform_front/config/providers.dart';

class IndicatorTextWidget extends ConsumerWidget {
  const IndicatorTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Indicator selectedIndicator = ref.watch(selectedIndicatorProvider);

    return Text(
      selectedIndicator.heading,
      style: kH3PoppinsMedium,
    );
  }
}
