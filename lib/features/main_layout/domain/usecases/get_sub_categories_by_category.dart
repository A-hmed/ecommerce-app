import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/app_error.dart';
import '../model/category.dart';
import '../repository/home_repository.dart';

@injectable
class GetSubCategoriesByCategory {
  HomeRepository homeRepository;

  GetSubCategoriesByCategory(this.homeRepository);

  Future<Either<Failure, List<Category>>> execute(String categoryId) async {
    return homeRepository.loadSubCategory(categoryId);
  }
}
