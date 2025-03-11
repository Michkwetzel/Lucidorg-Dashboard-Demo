import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/enums.dart';

class MyWidget extends ConsumerWidget {
  final Widget child;
  final Permission permission;
  
  const MyWidget({required this.child, required this.permission ,super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //TODO: Finish

    return const Placeholder();
  }
}