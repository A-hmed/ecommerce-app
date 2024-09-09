import 'package:ecommerce_app/features/base/failures/failures.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:ecommerce_app/features/main_layout/domain/repositories/home_repository.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoriesUseCase {
  HomeRepository homeRepository;

  GetCategoriesUseCase(this.homeRepository);

  Future<Either<Failure, List<Category>>> execute() {
    return homeRepository.getCategories();
  }
}
