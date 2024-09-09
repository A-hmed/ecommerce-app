import 'package:ecommerce_app/features/main_layout/data/model/response/category_dm.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoryMapper {
  Category toCategory(CategoryDM categoryDM) => Category(
      id: categoryDM.id!,
      name: categoryDM.name ?? "",
      image: categoryDM.image ?? "");

  List<Category> toCategories(List<CategoryDM> categoriesDM) =>
      categoriesDM.map((categoryDM) => toCategory(categoryDM)).toList();
}
