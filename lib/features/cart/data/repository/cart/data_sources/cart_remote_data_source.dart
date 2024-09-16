import 'package:ecommerce_app/features/base/failures/failures.dart';
import 'package:ecommerce_app/features/cart/data/model/response/cart_dm.dart';
import 'package:either_dart/either.dart';

abstract class CartRemoteDataSource {
  Future<Either<Failure, CartDM>> getUserCart();

  Future<Either<Failure, CartDM>> addProductToCart(String productId);

  Future<Either<Failure, CartDM>> removeProductFromCart(String productId);

  Future<Either<Failure, CartDM>> updateProductQuantity(
      String productId, int quantity);
}
