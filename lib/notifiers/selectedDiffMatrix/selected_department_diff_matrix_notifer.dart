import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/config/enums.dart';

class SelectedDepartmentDiffMatrixNotifer extends StateNotifier<Department> {
  SelectedDepartmentDiffMatrixNotifer() : super(Department.ceo);

  void changeDepartmentSelected(Department department) {
    state = department;
  }
}
