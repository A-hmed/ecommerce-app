import 'package:ecommerce_app/features/main_layout/data/model/product_dm.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductMapper {
  Product toProduct(ProductDM productDm) {
    return Product(
        image: productDm.imageCover ?? "",
        title: productDm.title ?? "",
        price: productDm.price?.toDouble() ?? 0.0,
        description: productDm.description ?? "",
        priceBeforeDiscount: 0,
        //todo: get this from backend side
        rating: productDm.ratingsAverage?.toDouble() ?? 0.0);
  }
}
