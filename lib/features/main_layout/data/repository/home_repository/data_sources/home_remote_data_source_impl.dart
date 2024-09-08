import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/resources/constants_manager.dart';
import 'package:ecommerce_app/core/utils/app_error.dart';
import 'package:ecommerce_app/features/main_layout/data/model/ProductsResponse.dart';
import 'package:ecommerce_app/features/main_layout/data/model/categories_response.dart';
import 'package:ecommerce_app/features/main_layout/data/model/category_dm.dart';
import 'package:ecommerce_app/features/main_layout/data/model/product_dm.dart';
import 'package:ecommerce_app/features/main_layout/data/model/sub_categories_response.dart';
import 'package:ecommerce_app/features/main_layout/data/model/sub_category.dart';
import 'package:ecommerce_app/features/main_layout/data/repository/home_repository/data_sources/home_remote_data_source.dart';
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final String categoryUrl = "/api/v1/categories";
  final String productsUrl = "/api/v1/products";

  Dio dio;

  HomeRemoteDataSourceImpl(this.dio);

  @override
  Future<Either<Failure, List<CategoryDM>>> loadCategories() async {
    try {
      Response serverResponse = await dio.get(categoryUrl);
      CategoriesResponse categoriesResponse =
          CategoriesResponse.fromJson(serverResponse.data);
      if (serverResponse.statusCode! >= 200 &&
          serverResponse.statusCode! < 300) {
        return Right(categoriesResponse.data!);
      } else {
        return Left(ApiFailure(AppConstants.defaultErrorMessage));
      }
    } catch (e) {
      return Left(ApiFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductDM>>> loadProducts() async {
    try {
      Response serverResponse = await dio.get(productsUrl);
      ProductsResponse productsResponse =
          ProductsResponse.fromJson(serverResponse.data);
      if (serverResponse.statusCode! >= 200 &&
          serverResponse.statusCode! < 300) {
        return Right(productsResponse.data!);
      } else {
        return Left(ApiFailure(AppConstants.defaultErrorMessage));
      }
    } catch (e) {
      return Left(ApiFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SubCategoryDM>>> loadSubCategories(
      String categoryId) async {
    try {
      Response serverResponse =
          await dio.get("/api/v1/categories/$categoryId/subcategories");
      SubCategoriesResponse subCategoriesResponse =
          SubCategoriesResponse.fromJson(serverResponse.data);
      if (serverResponse.statusCode! >= 200 &&
          serverResponse.statusCode! < 300) {
        return Right(subCategoriesResponse.data!);
      } else {
        return Left(ApiFailure(AppConstants.defaultErrorMessage));
      }
    } catch (e) {
      return Left(ApiFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductDM>>> loadProductsByCategory(
      String categoryId) async {
    try {
      Response serverResponse = await dio
          .get(productsUrl, queryParameters: {"category[in]": categoryId});
      ProductsResponse productsResponse =
          ProductsResponse.fromJson(serverResponse.data);
      if (serverResponse.statusCode! >= 200 &&
          serverResponse.statusCode! < 300) {
        return Right(productsResponse.data!);
      } else {
        return Left(ApiFailure(AppConstants.defaultErrorMessage));
      }
    } catch (e) {
      return Left(ApiFailure(e.toString()));
    }
  }
}
