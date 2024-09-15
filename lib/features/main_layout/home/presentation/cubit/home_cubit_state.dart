import 'package:ecommerce_app/features/base/base_api_state.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';

class HomeCubitState {
  late BaseApiState categoriesApiState;
  late BaseApiState productApiState;
  late BaseApiState subCategoriesApiState;
  Category? selectedCategory;

  HomeCubitState(
      {required this.categoriesApiState,
      required this.productApiState,
      required this.subCategoriesApiState,
      this.selectedCategory});

  HomeCubitState.initial() {
    categoriesApiState = BaseLoadingState();
    productApiState = BaseLoadingState();
    subCategoriesApiState = BaseIdleState();
  }

  HomeCubitState copyWith({
    BaseApiState? categoriesApiState,
    BaseApiState? productApiState,
    BaseApiState? subCategoriesApiState,
    Category? selectedCategory,
  }) {
    return HomeCubitState(
      categoriesApiState: categoriesApiState ?? this.categoriesApiState,
      productApiState: productApiState ?? this.productApiState,
      subCategoriesApiState:
          subCategoriesApiState ?? this.subCategoriesApiState,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}