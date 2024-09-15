import 'package:ecommerce_app/features/base/base_api_state.dart';

class ProductsScreenState {
  late BaseApiState productsApiState;

  ProductsScreenState({required this.productsApiState});

  ProductsScreenState.initial() {
    productsApiState = BaseLoadingState();
  }

  ProductsScreenState copyWith({BaseApiState? productsApiState}) =>
      ProductsScreenState(
          productsApiState: productsApiState ?? this.productsApiState);
}
