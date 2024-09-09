import 'package:ecommerce_app/features/main_layout/data/model/response/category_dm.dart';
import 'package:ecommerce_app/features/main_layout/domain/mappers/category_mapper.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/response/product_dm.dart';
import '../model/product.dart';

@injectable
class ProductMapper {
  CategoryMapper categoryMapper;

  ProductMapper(this.categoryMapper);

  Product mapProductDMToProduct(ProductDM productDM) {
    return Product(
      sold: productDM.sold ?? 0,
      images: productDM.images ?? [],
      subcategory: categoryMapper.toCategories(productDM.subcategory ?? []),
      ratingsQuantity: productDM.ratingsQuantity ?? 0,
      id: productDM.id!,
      title: productDM.title ?? '',
      description: productDM.description ?? '',
      quantity: productDM.quantity ?? 0,
      price: productDM.price ?? 0.0,
      imageCover: productDM.imageCover ?? '',
      category: categoryMapper.toCategory(productDM.category ?? CategoryDM()),
      brand: categoryMapper.toCategory(productDM.brand ?? CategoryDM()),
      ratingsAverage: productDM.ratingsAverage ?? 0.0,
    );
  }

  List<Product> toProducts(List<ProductDM> productsDMs) {
    return productsDMs
        .map((productDM) => mapProductDMToProduct(productDM))
        .toList();
  }
}
