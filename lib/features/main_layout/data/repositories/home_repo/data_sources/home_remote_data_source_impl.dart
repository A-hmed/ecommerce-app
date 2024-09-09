import 'package:dio/dio.dart';
import 'package:ecommerce_app/features/base/data/utils/dio_utils.dart';
import 'package:ecommerce_app/features/base/failures/failures.dart';
import 'package:ecommerce_app/features/main_layout/data/model/response/categories_response.dart';
import 'package:ecommerce_app/features/main_layout/data/model/response/category_dm.dart';
import 'package:ecommerce_app/features/main_layout/data/model/response/product_dm.dart';
import 'package:ecommerce_app/features/main_layout/data/model/response/products_response.dart';
import 'package:ecommerce_app/features/main_layout/data/repositories/home_repo/data_sources/home_remote_data_source.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  Dio dio;
  final String _categoriesEndPoint = "/api/v1/categories";
  final String _productsEndPoint = "/api/v1/products";

  HomeRemoteDataSourceImpl(this.dio);

  @override
  Future<Either<Failure, List<CategoryDM>>> getCategories() async {
    try {
      Response serverResponse = await dio.get(_categoriesEndPoint);
      if (serverResponse.isSuccessful) {
        CategoriesResponse categoriesResponse =
            CategoriesResponse.fromJson(serverResponse.data);
        return Right(categoriesResponse.data!);
      } else {
        return Left(ApiFailure());
      }
    } catch (e) {
      print("Exception while calling getCategories e: ${e}");
      return Left(ApiFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductDM>>> getProducts() async {
    try {
      Response serverResponse = await dio.get(_productsEndPoint);
      if (serverResponse.isSuccessful) {
        ProductsResponse productsResponse =
            ProductsResponse.fromJson(serverResponse.data);
        return Right(productsResponse.data!);
      } else {
        return Left(ApiFailure());
      }
    } catch (e) {
      print("Exception while calling getProducts e: ${e}");
      return Left(ApiFailure());
    }
  }
}
