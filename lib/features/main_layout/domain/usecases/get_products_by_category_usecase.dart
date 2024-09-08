import 'package:ecommerce_app/core/utils/app_error.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../repository/home_repository.dart';

@injectable
class GetProductsByCategoryUseCase {
  HomeRepository homeRepository;

  GetProductsByCategoryUseCase(this.homeRepository);

  Future<Either<Failure, List<Product>>> execute(String categoryId) async {
    return homeRepository.loadProductsByCategory(categoryId);
  }
}
