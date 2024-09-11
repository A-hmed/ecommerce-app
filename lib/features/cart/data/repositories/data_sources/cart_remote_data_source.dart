import 'package:ecommerce_app/core/utils/app_error.dart';
import 'package:ecommerce_app/features/cart/data/model/response/cart_dm.dart';
import 'package:either_dart/either.dart';

abstract class CartRemoteDataSource {
  Future<Either<Failure, CartDM>> getCart();

  Future<Either<Failure, CartDM>> addToCart(String productId);

  Future<Either<Failure, CartDM>> removeFromCart(String productId);

  Future<Either<Failure, CartDM>> updateCartItemQuantity(
      String productId, int count);
}
