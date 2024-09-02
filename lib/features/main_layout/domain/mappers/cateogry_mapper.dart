import 'package:ecommerce_app/features/main_layout/data/model/category_dm.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoryMapper {
  Category toCategory(CategoryDM model) {
    return Category(name: model.name, id: model.id, imageUrl: model.image);
  }
}
