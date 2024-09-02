import 'package:ecommerce_app/core/utils/app_error.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:ecommerce_app/features/main_layout/domain/repository/home_repository.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoriesUseCase {
  HomeRepository homeRepository;

  GetCategoriesUseCase(this.homeRepository);

  Future<Either<Failure, List<Category>>> execute() async {
    return homeRepository.loadCategories();
  }
}
