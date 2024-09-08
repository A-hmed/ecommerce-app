import 'package:ecommerce_app/core/utils/base_api_state.dart';

class HomeCubitState {
  final BaseApiState categoriesApi;
  final BaseApiState productsApi;
  final BaseApiState subCategoriesApi;

  // Default Constructor
  HomeCubitState({
    required this.categoriesApi,
    required this.productsApi,
    required this.subCategoriesApi,
  });

  // Named Constructor for Initial State
  HomeCubitState.initial()
      : categoriesApi = BaseLoadingState(),
        productsApi = BaseLoadingState(),
        subCategoriesApi = BaseIdleState();

  // copyWith Method
  HomeCubitState copyWith({
    BaseApiState? categoriesApi,
    BaseApiState? productsApi,
    BaseApiState? subCategoriesApi,
  }) {
    return HomeCubitState(
      categoriesApi: categoriesApi ?? this.categoriesApi,
      productsApi: productsApi ?? this.productsApi,
      subCategoriesApi: subCategoriesApi ?? this.subCategoriesApi,
    );
  }
}
