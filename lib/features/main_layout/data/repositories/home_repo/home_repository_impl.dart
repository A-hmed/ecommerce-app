import 'package:ecommerce_app/features/base/failures/failures.dart';
import 'package:ecommerce_app/features/main_layout/data/model/response/category_dm.dart';
import 'package:ecommerce_app/features/main_layout/data/model/response/product_dm.dart';
import 'package:ecommerce_app/features/main_layout/data/repositories/home_repo/data_sources/home_remote_data_source.dart';
import 'package:ecommerce_app/features/main_layout/domain/mappers/category_mapper.dart';
import 'package:ecommerce_app/features/main_layout/domain/mappers/product_mapper.dart';
import 'package:ecommerce_app/features/main_layout/domain/repositories/home_repository.dart';
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../domain/model/category.dart';
import '../../../domain/model/product.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl extends HomeRepository {
  InternetConnectionChecker internetConnectionChecker;
  HomeRemoteDataSource homeRemoteDataSource;
  CategoryMapper categoryMapper;
  ProductMapper productMapper;

  HomeRepositoryImpl(this.homeRemoteDataSource, this.internetConnectionChecker,
      this.categoryMapper, this.productMapper);

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    if (await internetConnectionChecker.hasConnection) {
      Either<Failure, List<CategoryDM>> either =
          await homeRemoteDataSource.getCategories();
      if (either.isRight) {
        return Right(categoryMapper.toCategories(either.right));
      } else {
        return Left(either.left);
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts([String? category]) async {
    if (await internetConnectionChecker.hasConnection) {
      Either<Failure, List<ProductDM>> either =
          await homeRemoteDataSource.getProducts(category);
      if (either.isRight) {
        return Right(productMapper.toProducts(either.right));
      } else {
        return Left(either.left);
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getSubCategories(
      String categoryId) async {
    if (await internetConnectionChecker.hasConnection) {
      Either<Failure, List<CategoryDM>> either =
          await homeRemoteDataSource.getSubCategories(categoryId);
      if (either.isRight) {
        return Right(categoryMapper.toCategories(either.right));
      } else {
        return Left(either.left);
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
