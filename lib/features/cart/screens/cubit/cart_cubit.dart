import 'dart:async';

import 'package:ecommerce_app/features/base/base_api_state.dart';
import 'package:ecommerce_app/features/base/failures/failures.dart';
import 'package:ecommerce_app/features/cart/domain/model/cart.dart';
import 'package:ecommerce_app/features/cart/domain/repository/cart_repository.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartCubit extends Cubit<BaseApiState> {
  final CartRepository _cartRepository;
  Cart? latestCart;
  StreamSubscription? subscription;

  CartCubit(this._cartRepository) : super(BaseIdleState());

  void loadUserCart() async {
    emit(BaseLoadingState());
    Either<Failure, Cart> either = await _cartRepository.getUserCart();
    if (either.isLeft) {
      emit(BaseErrorState(either.left));
    } else {
      latestCart = either.right;
      emit(BaseSuccessState(either.right));
    }
  }

  void addProductToCart(String productId) async {
    emit(BaseLoadingState());
    Either<Failure, Cart> either =
        await _cartRepository.addProductToCart(productId);
    if (either.isLeft) {
      emit(BaseErrorState(either.left));
    } else {
      latestCart = either.right;
      emit(BaseSuccessState(either.right));
    }
  }

  void removeProductFromCart(String productId) async {
    emit(BaseLoadingState());
    Either<Failure, Cart> either =
        await _cartRepository.removeProductFromCart(productId);
    if (either.isLeft) {
      emit(BaseErrorState(either.left));
    } else {
      latestCart = either.right;
      emit(BaseSuccessState(either.right));
    }
  }

  void updateProductCartQuantity(String productId, int quantity) async {
    emit(BaseLoadingState());
    Either<Failure, Cart> either =
        await _cartRepository.updateProductQuantity(productId, quantity);
    if (either.isLeft) {
      emit(BaseErrorState(either.left));
    } else {
      latestCart = either.right;
      emit(BaseSuccessState(either.right));
    }
  }

  bool isInCart(String productId) {
    for (var product in latestCart?.products ?? []) {
      if (productId == product.id) {
        return true;
      }
    }
    return false;
  }
}
