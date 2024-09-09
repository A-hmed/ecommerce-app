import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';
import 'package:ecommerce_app/features/main_layout/domain/repositories/home_repository.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../base/failures/failures.dart';

@injectable
class GetProductsUseCase {
  HomeRepository homeRepository;

  GetProductsUseCase(this.homeRepository);

  Future<Either<Failure, List<Product>>> execute() {
    return homeRepository.getProducts();
  }
}
