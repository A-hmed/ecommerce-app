import 'package:ecommerce_app/core/utils/base_api_state.dart';

class ProductsCubitState {
  BaseApiState productsApi;

  // Default constructor
  ProductsCubitState({required this.productsApi});

  // Initial state constructor
  ProductsCubitState.initial() : productsApi = BaseLoadingState();

  // copyWith method
  ProductsCubitState copyWith({
    BaseApiState? productsApi,
  }) {
    return ProductsCubitState(
      productsApi: productsApi ?? this.productsApi,
    );
  }
}
