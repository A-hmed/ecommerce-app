import 'package:ecommerce_app/features/cart/data/model/response/cart_dm.dart';
import 'package:ecommerce_app/features/cart/data/model/response/cart_product_dm.dart';
import 'package:ecommerce_app/features/cart/domain/model/cart.dart';
import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartMapper {
  Cart toCart(CartDM cartDm) {
    return Cart(
      products: cartDm.products!
          .map((cartProduct) => cartProductToProduct(cartProduct))
          .toList(),
      totalPrice: cartDm.totalCartPrice?.toDouble() ?? 0,
    );
  }

  Product cartProductToProduct(CartProductDM cartProduct) {
    return Product(
        id: cartProduct.product!.id!,
        image: cartProduct.product?.imageCover ?? "",
        title: cartProduct.product?.title ?? "",
        price: cartProduct.product?.price?.toDouble() ?? 0.0,
        description: cartProduct.product?.description ?? "",
        priceBeforeDiscount: cartProduct.product?.price?.toDouble() ?? 0.0,
        rating: cartProduct.product?.ratingsAverage?.toDouble() ?? 0.0,
        totalPriceInCart: cartProduct.totalPriceInCart?.toDouble() ?? 0,
        numberOfItemsInCart: cartProduct.numberOfItemsInCart?.toInt() ?? 0);
  }
}
