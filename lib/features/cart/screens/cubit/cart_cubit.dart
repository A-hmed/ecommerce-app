import 'package:ecommerce_app/core/utils/app_error.dart';
import 'package:ecommerce_app/core/utils/base_api_state.dart';
import 'package:ecommerce_app/features/cart/domain/model/cart.dart';
import 'package:ecommerce_app/features/cart/domain/repository/cart_repository.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartCubit extends Cubit<BaseApiState> {
  CartRepository cartRepository;
  Cart? cart;

  CartCubit(this.cartRepository) : super(BaseIdleState());

  void loadCart() async {
    emit(BaseLoadingState());
    Either<Failure, Cart> either = await cartRepository.getCart();
    if (either.isRight) {
      cart = either.right;
      emit(BaseSuccessState(either.right));
    } else {
      emit(BaseErrorState(either.left));
    }
  }

  void addToCart(String productId) async {
    emit(BaseLoadingState());
    Either<Failure, Cart> either = await cartRepository.addToCart(productId);
    if (either.isRight) {
      cart = either.right;
      emit(BaseSuccessState(either.right));
    } else {
      emit(BaseErrorState(either.left));
    }
  }

  void removeToCart(String productId) async {
    emit(BaseLoadingState());
    Either<Failure, Cart> either =
        await cartRepository.removeFromCart(productId);
    if (either.isRight) {
      cart = either.right;
      emit(BaseSuccessState(either.right));
    } else {
      emit(BaseErrorState(either.left));
    }
  }

  void updateItemQuantity(String productId, int quantity) async {
    emit(BaseLoadingState());
    Either<Failure, Cart> either =
        await cartRepository.updateCartItemQuantity(productId, quantity);
    if (either.isRight) {
      cart = either.right;
      emit(BaseSuccessState(either.right));
    } else {
      emit(BaseErrorState(either.left));
    }
  }

  bool isProductInCart(String productId) {
    for (Product p in cart?.products ?? []) {
      if (productId == p.id) return true;
    }
    return false;
  }
}
