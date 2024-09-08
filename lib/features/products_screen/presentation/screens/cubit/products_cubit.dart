import 'package:ecommerce_app/core/utils/app_error.dart';
import 'package:ecommerce_app/core/utils/base_api_state.dart';
import 'package:ecommerce_app/features/main_layout/domain/usecases/get_products_by_category_usecase.dart';
import 'package:ecommerce_app/features/products_screen/presentation/screens/cubit/products_cubit_state.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../main_layout/domain/model/product.dart';

@injectable
class ProductsCubit extends Cubit<ProductsCubitState> {
  GetProductsByCategoryUseCase getProductsByCategoryUseCase;

  ProductsCubit(this.getProductsByCategoryUseCase)
      : super(ProductsCubitState.initial());

  void loadProducts(String categoryId) async {
    emit(state.copyWith(productsApi: BaseLoadingState()));
    Either<Failure, List<Product>> response =
        await getProductsByCategoryUseCase.execute(categoryId);
    if (response.isRight) {
      emit(state.copyWith(productsApi: BaseSuccessState(response.right)));
    } else {
      emit(state.copyWith(productsApi: BaseErrorState(response.left)));
    }
  }
}
