import 'package:ecommerce_app/features/base/base_api_state.dart';
import 'package:ecommerce_app/features/base/failures/failures.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';
import 'package:ecommerce_app/features/products_screen/domain/get_products_by_category.dart';
import 'package:ecommerce_app/features/products_screen/presentation/screens/cubit/products_screen_state.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductsScreenCubit extends Cubit<ProductsScreenState> {
  final GetProductsByCategoryUseCase _getProductsByCategoryUseCase;

  ProductsScreenCubit(this._getProductsByCategoryUseCase)
      : super(ProductsScreenState.initial());

  void loadProducts(String category) async {
    emit(state.copyWith(productsApiState: BaseLoadingState()));
    Either<Failure, List<Product>> either =
        await _getProductsByCategoryUseCase.execute(category);
    if (either.isRight) {
      emit(state.copyWith(productsApiState: BaseSuccessState(either.right)));
    } else {
      emit(state.copyWith(productsApiState: BaseErrorState(either.left)));
    }
  }
}
