// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/constants.dart';
import 'package:platform_front/config/providers.dart';

class ResultsSideBar extends ConsumerWidget {
  const ResultsSideBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(resultsDisplayProvider);
    return Container(
      margin: EdgeInsets.only(left: 5, bottom: 5),
      width: 400,
      decoration: kboxShadowNormal,
      child: Placeholder(),
    );
  }
}
