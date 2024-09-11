import 'package:ecommerce_app/features/cart/domain/model/cart.dart';
import 'package:either_dart/either.dart';

import '../../../../core/utils/app_error.dart';

abstract class CartRepository {
  Future<Either<Failure, Cart>> getCart();

  Future<Either<Failure, Cart>> addToCart(String productId);

  Future<Either<Failure, Cart>> removeFromCart(String productId);

  Future<Either<Failure, Cart>> updateCartItemQuantity(
      String productId, int count);
}
