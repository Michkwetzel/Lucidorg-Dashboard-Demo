import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/lucid_ORG/config/enums_org.dart';

class ImpactDisplayNotifier extends StateNotifier<ImpactSection> {
  ImpactDisplayNotifier() : super(ImpactSection.orgImpact);

  void setDisplay(ImpactSection section) {
    state = section;
  }
}
