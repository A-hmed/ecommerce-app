import 'package:dio/dio.dart';
import 'package:ecommerce_app/features/base/data/utils/dio_utils.dart';
import 'package:ecommerce_app/features/base/failures/failures.dart';
import 'package:ecommerce_app/features/cart/data/model/response/cart_dm.dart';
import 'package:ecommerce_app/features/cart/data/model/response/cart_response.dart';
import 'package:ecommerce_app/features/cart/data/repository/cart/data_sources/cart_remote_data_source.dart';
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRemoteDataSource)
class CartRemoteDataSourceImpl extends CartRemoteDataSource {
  final cartUrl = "/api/v1/cart";
  final Dio _dio;

  CartRemoteDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, CartDM>> addProductToCart(String productId) async {
    try {
      Response serverResponse =
          await _dio.post(cartUrl, data: {"productId": productId});
      if (serverResponse.isSuccessful) {
        return getUserCart();
      } else {
        return Left(ApiFailure());
      }
    } catch (e) {
      return Left(ApiFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartDM>> getUserCart() async {
    try {
      Response serverResponse = await _dio.get(cartUrl);
      if (serverResponse.isSuccessful) {
        CartResponse cartResponse = CartResponse.fromJson(serverResponse.data);
        return Right(cartResponse.cartDm!);
      } else {
        return Left(ApiFailure());
      }
    } catch (e) {
      return Left(ApiFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartDM>> removeProductFromCart(
      String productId) async {
    try {
      Response serverResponse = await _dio.delete("$cartUrl/$productId");
      if (serverResponse.isSuccessful) {
        CartResponse cartResponse = CartResponse.fromJson(serverResponse.data);
        return Right(cartResponse.cartDm!);
      } else {
        return Left(ApiFailure());
      }
    } catch (e) {
      return Left(ApiFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartDM>> updateProductQuantity(
      String productId, int quantity) async {
    try {
      Response serverResponse =
          await _dio.put("$cartUrl/$productId", data: {"count": quantity});
      if (serverResponse.isSuccessful) {
        CartResponse cartResponse = CartResponse.fromJson(serverResponse.data);
        return Right(cartResponse.cartDm!);
      } else {
        return Left(ApiFailure());
      }
    } catch (e) {
      return Left(ApiFailure(e.toString()));
    }
  }
}
