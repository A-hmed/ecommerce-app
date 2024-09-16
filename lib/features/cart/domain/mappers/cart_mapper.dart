import 'package:ecommerce_app/features/cart/data/model/response/cart_dm.dart';
import 'package:ecommerce_app/features/cart/data/model/response/cart_product_dm.dart';
import 'package:ecommerce_app/features/cart/domain/model/cart.dart';
import 'package:ecommerce_app/features/main_layout/data/model/response/category_dm.dart';
import 'package:ecommerce_app/features/main_layout/domain/mappers/category_mapper.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartMapper {
  CategoryMapper categoryMapper;

  CartMapper(this.categoryMapper);

  Cart mapToCart(CartDM cartDm) {
    return Cart(
        products: cartDm.products
                ?.map((cartProductDM) => mapCartProductToProduct(cartProductDM))
                .toList() ??
            [],
        totalCartPrice: cartDm.totalCartPrice?.toDouble() ?? 0);
  }

  Product mapCartProductToProduct(CartProductDM cartProductDM) {
    return Product(
        sold: cartProductDM.product?.sold ?? 0,
        images: cartProductDM.product?.images ?? [],
        subCategories: categoryMapper
            .toCategories(cartProductDM.product?.subcategory ?? []),
        ratingsQuantity: cartProductDM.product?.ratingsQuantity ?? 0,
        id: cartProductDM.product!.id!,
        title: cartProductDM.product?.title ?? "",
        description: cartProductDM.product?.description ?? "",
        quantity: cartProductDM.product?.quantity ?? 0,
        price: cartProductDM.product?.price ?? 0,
        imageCover: cartProductDM.product?.imageCover ?? "",
        category: categoryMapper
            .toCategory(cartProductDM.product?.category ?? CategoryDM()),
        brand: categoryMapper
            .toCategory(cartProductDM.product?.brand ?? CategoryDM()),
        ratingsAverage: cartProductDM.product?.ratingsAverage ?? 0,
        totalCartPrice: cartProductDM.totalPriceInCart ?? 0,
        totalItemsInCart: cartProductDM.totalItemsCountInCart ?? 0);
  }
}
