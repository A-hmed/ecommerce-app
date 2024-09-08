import 'package:ecommerce_app/core/utils/app_error.dart';
import 'package:ecommerce_app/features/main_layout/data/model/category_dm.dart';
import 'package:ecommerce_app/features/main_layout/data/model/product_dm.dart';
import 'package:ecommerce_app/features/main_layout/data/model/sub_category.dart';
import 'package:either_dart/either.dart';

abstract class HomeRemoteDataSource {
  Future<Either<Failure, List<CategoryDM>>> loadCategories();

  Future<Either<Failure, List<ProductDM>>> loadProducts();

  Future<Either<Failure, List<ProductDM>>> loadProductsByCategory(
      String categoryId);

  Future<Either<Failure, List<SubCategoryDM>>> loadSubCategories(
      String categoryId);
}
