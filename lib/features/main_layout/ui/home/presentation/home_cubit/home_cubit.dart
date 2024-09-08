import 'package:ecommerce_app/core/utils/app_error.dart';
import 'package:ecommerce_app/core/utils/base_api_state.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';
import 'package:ecommerce_app/features/main_layout/domain/usecases/categories_usecase.dart';
import 'package:ecommerce_app/features/main_layout/domain/usecases/get_sub_categories_by_category.dart';
import 'package:ecommerce_app/features/main_layout/domain/usecases/most_selling_products_usecase.dart';
import 'package:ecommerce_app/features/main_layout/ui/home/presentation/home_cubit/home_cubit_state.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends Cubit<HomeCubitState> {
  GetCategoriesUseCase categoriesUseCase;
  MostSellingProductsUseCase mostSellingProductsUseCase;
  GetSubCategoriesByCategory getSubCategoriesByCategory;

  HomeCubit(this.categoriesUseCase, this.mostSellingProductsUseCase,
      this.getSubCategoriesByCategory)
      : super(HomeCubitState.initial());

  void loadCategories() async {
    emit(state.copyWith(categoriesApi: BaseLoadingState()));
    Either<Failure, List<Category>> response =
        await categoriesUseCase.execute();
    if (response.isRight) {
      emit(state.copyWith(categoriesApi: BaseSuccessState(response.right)));
    } else {
      emit(state.copyWith(categoriesApi: BaseErrorState(response.left)));
    }
  }

  void loadProducts() async {
    emit(state.copyWith(productsApi: BaseLoadingState()));
    Either<Failure, List<Product>> response =
        await mostSellingProductsUseCase.execute();
    if (response.isRight) {
      emit(state.copyWith(productsApi: BaseSuccessState(response.right)));
    } else {
      emit(state.copyWith(productsApi: BaseErrorState(response.left)));
    }
  }

  void loadSubCategories(String categoryId) async {
    emit(state.copyWith(subCategoriesApi: BaseLoadingState()));
    Either<Failure, List<Category>> response =
        await getSubCategoriesByCategory.execute(categoryId);
    if (response.isRight) {
      emit(state.copyWith(subCategoriesApi: BaseSuccessState(response.right)));
    } else {
      emit(state.copyWith(subCategoriesApi: BaseErrorState(response.left)));
    }
  }
}
