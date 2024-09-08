import 'package:ecommerce_app/features/main_layout/data/model/category_dm.dart';
import 'package:ecommerce_app/features/main_layout/data/model/sub_category.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoryMapper {
  Category toCategory(CategoryDM model) {
    return Category(name: model.name, id: model.id, imageUrl: model.image);
  }

  Category subCategorytoCategory(SubCategoryDM model) {
    return Category(
        name: model.name,
        id: model.id,
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSF-HPD0KjpoJknxtehc4b2e3IUCvLzAdWTfw&s");
  }
}
