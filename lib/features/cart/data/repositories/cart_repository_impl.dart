import 'package:ecommerce_app/core/utils/app_error.dart';
import 'package:ecommerce_app/features/cart/data/model/response/cart_dm.dart';
import 'package:ecommerce_app/features/cart/data/repositories/data_sources/cart_remote_data_source.dart';
import 'package:ecommerce_app/features/cart/domain/mappers/cart_mapper.dart';
import 'package:ecommerce_app/features/cart/domain/model/cart.dart';
import 'package:ecommerce_app/features/cart/domain/repository/cart_repository.dart';
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@Injectable(as: CartRepository)
class CartRepositoryImpl extends CartRepository {
  InternetConnectionChecker internetConnectionChecker;
  CartMapper cartMapper;
  CartRemoteDataSource cartRemoteDataSource;

  CartRepositoryImpl(this.internetConnectionChecker, this.cartRemoteDataSource,
      this.cartMapper);

  @override
  Future<Either<Failure, Cart>> addToCart(String productId) async {
    if (await internetConnectionChecker.hasConnection) {
      Either<Failure, CartDM> either =
          await cartRemoteDataSource.addToCart(productId);
      if (either.isRight) {
        return Right(cartMapper.toCart(either.right));
      } else {
        return Left(either.left);
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Cart>> getCart() async {
    if (await internetConnectionChecker.hasConnection) {
      Either<Failure, CartDM> either = await cartRemoteDataSource.getCart();
      if (either.isRight) {
        return Right(cartMapper.toCart(either.right));
      } else {
        return Left(either.left);
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Cart>> removeFromCart(String productId) async {
    if (await internetConnectionChecker.hasConnection) {
      Either<Failure, CartDM> either =
          await cartRemoteDataSource.removeFromCart(productId);
      if (either.isRight) {
        return Right(cartMapper.toCart(either.right));
      } else {
        return Left(either.left);
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Cart>> updateCartItemQuantity(
      String productId, int count) async {
    if (await internetConnectionChecker.hasConnection) {
      Either<Failure, CartDM> either =
          await cartRemoteDataSource.updateCartItemQuantity(productId, count);
      if (either.isRight) {
        return Right(cartMapper.toCart(either.right));
      } else {
        return Left(either.left);
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
