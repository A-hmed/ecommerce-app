import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/utils/app_error.dart';
import 'package:ecommerce_app/features/cart/data/model/response/cart_dm.dart';
import 'package:ecommerce_app/features/cart/data/model/response/cart_response.dart';
import 'package:ecommerce_app/features/utils/dio_utils.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import 'cart_remote_data_source.dart';

@Injectable(as: CartRemoteDataSource)
class CartRemoteDataSourceImpl extends CartRemoteDataSource {
  final String cartUrl = "/api/v1/cart";
  Dio dio;

  CartRemoteDataSourceImpl(this.dio);

  @override
  Future<Either<Failure, CartDM>> addToCart(String productId) async {
    try {
      Response serverResponse =
          await dio.post(cartUrl, data: {"productId": productId});
      if (serverResponse.isSuccessful) {
        return getCart();
      } else {
        return Left(ApiFailure());
      }
    } catch (e) {
      return Left(ApiFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartDM>> getCart() async {
    try {
      Response serverResponse = await dio.get(cartUrl);
      if (serverResponse.isSuccessful) {
        CartResponse cartResponse = CartResponse.fromJson(serverResponse.data);
        return Right(cartResponse.cart!);
      } else {
        return Left(ApiFailure());
      }
    } catch (e) {
      return Left(ApiFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartDM>> removeFromCart(String productId) async {
    try {
      Response serverResponse = await dio.delete("$cartUrl/$productId");
      if (serverResponse.isSuccessful) {
        CartResponse cartResponse = CartResponse.fromJson(serverResponse.data);
        return Right(cartResponse.cart!);
      } else {
        return Left(ApiFailure());
      }
    } catch (e) {
      return Left(ApiFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartDM>> updateCartItemQuantity(
      String productId, int count) async {
    try {
      Response serverResponse =
          await dio.put("$cartUrl/$productId", data: {"count": count});
      if (serverResponse.isSuccessful) {
        CartResponse cartResponse = CartResponse.fromJson(serverResponse.data);
        return Right(cartResponse.cart!);
      } else {
        return Left(ApiFailure());
      }
    } catch (e) {
      return Left(ApiFailure(e.toString()));
    }
  }
}
