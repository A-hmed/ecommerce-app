import 'package:ecommerce_app/features/base/base_api_state.dart';

class HomeCubitState {
  late BaseApiState categoriesApiState;
  late BaseApiState productApiState;

  HomeCubitState(
      {required this.categoriesApiState, required this.productApiState});

  HomeCubitState.initial() {
    categoriesApiState = BaseLoadingState();
    productApiState = BaseLoadingState();
  }

  HomeCubitState copyWith({
    BaseApiState? categoriesApiState,
    BaseApiState? productApiState,
  }) {
    return HomeCubitState(
      categoriesApiState: categoriesApiState ?? this.categoriesApiState,
      productApiState: productApiState ?? this.productApiState,
    );
  }
}
