import 'package:ecommerce_app/features/base/failures/failures.dart';
import 'package:ecommerce_app/features/cart/domain/model/cart.dart';
import 'package:either_dart/either.dart';

abstract class CartRepository {
  Future<Either<Failure, Cart>> getUserCart();

  Future<Either<Failure, Cart>> addProductToCart(String productId);

  Future<Either<Failure, Cart>> removeProductFromCart(String productId);

  Future<Either<Failure, Cart>> updateProductQuantity(
      String productId, int quantity);
}
