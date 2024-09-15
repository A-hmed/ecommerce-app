import 'package:ecommerce_app/features/base/failures/failures.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';
import 'package:ecommerce_app/features/main_layout/domain/repositories/home_repository.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductsByCategoryUseCase {
  HomeRepository homeRepository;

  GetProductsByCategoryUseCase(this.homeRepository);

  Future<Either<Failure, List<Product>>> execute(String categoryId) {
    return homeRepository.getProducts(categoryId);
  }
}
