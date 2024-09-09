import 'package:either_dart/either.dart';

import '../../../base/failures/failures.dart';
import '../model/category.dart';
import '../model/product.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Category>>> getCategories();

  Future<Either<Failure, List<Product>>> getProducts();
}
