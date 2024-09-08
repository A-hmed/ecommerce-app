import 'package:ecommerce_app/core/resources/constants_manager.dart';
import 'package:ecommerce_app/core/utils/app_error.dart';
import 'package:ecommerce_app/features/main_layout/data/model/category_dm.dart';
import 'package:ecommerce_app/features/main_layout/data/model/product_dm.dart';
import 'package:ecommerce_app/features/main_layout/data/model/sub_category.dart';
import 'package:ecommerce_app/features/main_layout/data/repository/home_repository/data_sources/home_remote_data_source.dart';
import 'package:ecommerce_app/features/main_layout/domain/mappers/cateogry_mapper.dart';
import 'package:ecommerce_app/features/main_layout/domain/mappers/product_mapper.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';
import 'package:ecommerce_app/features/main_layout/domain/repository/home_repository.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl extends HomeRepository {
  HomeRemoteDataSource homeRemoteDataSource;
  InternetConnectionChecker internetConnectionChecker;
  ProductMapper productMapper;
  CategoryMapper categoryMapper;

  HomeRepositoryImpl(this.homeRemoteDataSource, this.internetConnectionChecker,
      this.categoryMapper, this.productMapper);

  @override
  Future<Either<Failure, List<Category>>> loadCategories() async {
    bool isConnected = await internetConnectionChecker.hasConnection;
    if (isConnected) {
      Either<Failure, List<CategoryDM>> either =
          await homeRemoteDataSource.loadCategories();
      if (either.isRight) {
        return Right(either.right
            .map((categoryDm) => categoryMapper.toCategory(categoryDm))
            .toList());
      } else {
        return Left(either.left);
      }
    } else {
      return Left(ConnectionFailure(AppConstants.internetErrorMessage));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> loadProducts() async {
    bool isConnected = await internetConnectionChecker.hasConnection;
    if (isConnected) {
      Either<Failure, List<ProductDM>> either =
          await homeRemoteDataSource.loadProducts();

      if (either.isRight) {
        for (ProductDM item in either.right) {
          print("title, ${item.title}");
        }
        return Right(either.right
            .map((productDm) => productMapper.toProduct(productDm))
            .toList());
      } else {
        return Left(either.left);
      }
    } else {
      return Left(ConnectionFailure(AppConstants.internetErrorMessage));
    }
  }

  @override
  Future<Either<Failure, List<Category>>> loadSubCategory(
      String categoryId) async {
    bool isConnected = await internetConnectionChecker.hasConnection;
    if (isConnected) {
      Either<Failure, List<SubCategoryDM>> either =
          await homeRemoteDataSource.loadSubCategories(categoryId);
      if (either.isRight) {
        return Right(either.right
            .map((categoryDm) =>
                categoryMapper.subCategorytoCategory(categoryDm))
            .toList());
      } else {
        return Left(either.left);
      }
    } else {
      return Left(ConnectionFailure(AppConstants.internetErrorMessage));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> loadProductsByCategory(
      String categoryId) async {
    bool isConnected = await internetConnectionChecker.hasConnection;
    if (isConnected) {
      Either<Failure, List<ProductDM>> either =
          await homeRemoteDataSource.loadProductsByCategory(categoryId);

      if (either.isRight) {
        return Right(either.right
            .map((productDm) => productMapper.toProduct(productDm))
            .toList());
      } else {
        return Left(either.left);
      }
    } else {
      return Left(ConnectionFailure(AppConstants.internetErrorMessage));
    }
  }
}
