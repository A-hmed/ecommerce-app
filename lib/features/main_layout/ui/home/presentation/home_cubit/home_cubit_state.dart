import 'package:ecommerce_app/core/utils/base_api_state.dart';

class HomeCubitState {
  final BaseApiState categoriesApi;
  final BaseApiState productsApi;

  // Default Constructor
  HomeCubitState({
    required this.categoriesApi,
    required this.productsApi,
  });

  // Named Constructor for Initial State
  HomeCubitState.initial()
      : categoriesApi = BaseLoadingState(),
        productsApi = BaseLoadingState();

  // copyWith Method
  HomeCubitState copyWith({
    BaseApiState? categoriesApi,
    BaseApiState? productsApi,
  }) {
    return HomeCubitState(
      categoriesApi: categoriesApi ?? this.categoriesApi,
      productsApi: productsApi ?? this.productsApi,
    );
  }
}
