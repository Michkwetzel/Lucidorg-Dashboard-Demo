import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_front/core_config/enums.dart';
import 'package:platform_front/services/microServices/navigationService.dart';

class NavBarState {
  final NavBarButtonType selectedDisplay;
  final Product selectedProduct;

  NavBarState({required this.selectedDisplay, required this.selectedProduct});

  NavBarState copyWith({NavBarButtonType? selectedDisplay, Product? selectedProduct}) {
    return NavBarState(
      selectedDisplay: selectedDisplay ?? this.selectedDisplay,
      selectedProduct: selectedProduct ?? this.selectedProduct,
    );
  }

  factory NavBarState.init() {
    return NavBarState(
      selectedDisplay: NavBarButtonType.home_org,
      selectedProduct: Product.org,
    );
  }
}

class NavbarNotifer extends StateNotifier<NavBarState> {
  NavbarNotifer() : super(NavBarState.init());

  void changeDisplay(NavBarButtonType display) {
    state = state.copyWith(selectedDisplay: display);
  }

  void changeProduct(Product product) {
    String route = "/home_org";
    NavBarButtonType display = NavBarButtonType.home_org;

    switch (product) {
      case Product.org:
        break;
      case Product.hr:
        route = "/home_hr";
        display = NavBarButtonType.home_hr;
        break;
      case Product.board:
        route = "/home_board";
        display = NavBarButtonType.home_board;
        break;
    }

    state = state.copyWith(selectedProduct: product, selectedDisplay: display);
    NavigationService.navigateTo(route);
  }
}
