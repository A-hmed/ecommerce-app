import 'package:ecommerce_app/features/base/base_api_state.dart';
import 'package:ecommerce_app/features/base/failures/failures.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';
import 'package:ecommerce_app/features/main_layout/domain/usecase/get_categories_usecase.dart';
import 'package:ecommerce_app/features/main_layout/domain/usecase/get_product_usecase.dart';
import 'package:ecommerce_app/features/main_layout/home/presentation/cubit/home_cubit_state.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends Cubit<HomeCubitState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetProductsUseCase _getProductsUseCase;

  HomeCubit(this._getCategoriesUseCase, this._getProductsUseCase)
      : super(HomeCubitState.initial());

  void loadCategories() async {
    emit(state.copyWith(categoriesApiState: BaseLoadingState()));
    Either<Failure, List<Category>> either =
        await _getCategoriesUseCase.execute();
    if (either.isRight) {
      emit(state.copyWith(categoriesApiState: BaseSuccessState(either.right)));
    } else {
      emit(state.copyWith(categoriesApiState: BaseErrorState(either.left)));
    }
  }

  void loadProduct() async {
    emit(state.copyWith(productApiState: BaseLoadingState()));
    Either<Failure, List<Product>> either = await _getProductsUseCase.execute();
    if (either.isRight) {
      emit(state.copyWith(productApiState: BaseSuccessState(either.right)));
    } else {
      emit(state.copyWith(productApiState: BaseErrorState(either.left)));
    }
  }
}
