import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/enums.dart';

class ImpactDisplayNotifier extends StateNotifier<ImpactSection> {
  ImpactDisplayNotifier() : super(ImpactSection.orgImpact);

  void setDisplay(ImpactSection section) {
    state = section;
  }
}
