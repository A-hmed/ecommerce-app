import 'package:ecommerce_app/features/base/failures/failures.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:ecommerce_app/features/main_layout/domain/repositories/home_repository.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSubCategoriesByCategoryUseCase {
  HomeRepository homeRepository;

  GetSubCategoriesByCategoryUseCase(this.homeRepository);

  Future<Either<Failure, List<Category>>> execute(String categoryId) {
    return homeRepository.getSubCategories(categoryId);
  }
}
