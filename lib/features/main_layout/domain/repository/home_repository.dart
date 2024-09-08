import 'package:ecommerce_app/core/utils/app_error.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';
import 'package:either_dart/either.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Category>>> loadCategories();

  Future<Either<Failure, List<Product>>> loadProducts();

  Future<Either<Failure, List<Product>>> loadProductsByCategory(
      String categoryId);

  Future<Either<Failure, List<Category>>> loadSubCategory(String categoryId);
}
