import 'package:ecommerce_app/features/base/failures/failures.dart';
import 'package:ecommerce_app/features/cart/data/model/response/cart_dm.dart';
import 'package:ecommerce_app/features/cart/data/repository/cart/data_sources/cart_remote_data_source.dart';
import 'package:ecommerce_app/features/cart/domain/mappers/cart_mapper.dart';
import 'package:ecommerce_app/features/cart/domain/model/cart.dart';
import 'package:ecommerce_app/features/cart/domain/repository/cart_repository.dart';
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@Injectable(as: CartRepository)
class CartRepositoryImpl extends CartRepository {
  final CartRemoteDataSource _cartRemoteDataSource;
  final InternetConnectionChecker _internetConnectionChecker;
  final CartMapper _cartMapper;

  CartRepositoryImpl(this._internetConnectionChecker,
      this._cartRemoteDataSource, this._cartMapper);

  @override
  Future<Either<Failure, Cart>> addProductToCart(String productId) async {
    if (await _internetConnectionChecker.hasConnection) {
      Either<Failure, CartDM> either =
          await _cartRemoteDataSource.addProductToCart(productId);
      if (either.isRight) {
        return Right(_cartMapper.mapToCart(either.right));
      } else {
        return Left(either.left);
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Cart>> getUserCart() async {
    if (await _internetConnectionChecker.hasConnection) {
      Either<Failure, CartDM> either =
          await _cartRemoteDataSource.getUserCart();
      if (either.isRight) {
        return Right(_cartMapper.mapToCart(either.right));
      } else {
        return Left(either.left);
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Cart>> removeProductFromCart(String productId) async {
    if (await _internetConnectionChecker.hasConnection) {
      Either<Failure, CartDM> either =
          await _cartRemoteDataSource.removeProductFromCart(productId);
      if (either.isRight) {
        return Right(_cartMapper.mapToCart(either.right));
      } else {
        return Left(either.left);
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Cart>> updateProductQuantity(
      String productId, int quantity) async {
    if (await _internetConnectionChecker.hasConnection) {
      Either<Failure, CartDM> either = await _cartRemoteDataSource
          .updateProductQuantity(productId, quantity);
      if (either.isRight) {
        return Right(_cartMapper.mapToCart(either.right));
      } else {
        return Left(either.left);
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
