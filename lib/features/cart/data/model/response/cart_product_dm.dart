import 'package:ecommerce_app/features/main_layout/data/model/response/product_dm.dart';

class CartProductDM {
  CartProductDM({
    this.totalItemsCountInCart,
    this.id,
    this.product,
    this.totalPriceInCart,
  });

  CartProductDM.fromJson(dynamic json) {
    totalItemsCountInCart = json['count'];
    id = json['_id'];
    product =
        json['product'] != null ? ProductDM.fromJson(json['product']) : null;
    totalPriceInCart = json['price'];
  }

  num? totalItemsCountInCart;
  String? id;
  ProductDM? product;
  num? totalPriceInCart;

  CartProductDM copyWith({
    num? count,
    String? id,
    ProductDM? product,
    num? price,
  }) =>
      CartProductDM(
        totalItemsCountInCart: count ?? this.totalItemsCountInCart,
        id: id ?? this.id,
        product: product ?? this.product,
        totalPriceInCart: price ?? this.totalPriceInCart,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = totalItemsCountInCart;
    map['_id'] = id;
    if (product != null) {
      map['product'] = product?.toJson();
    }
    map['price'] = totalPriceInCart;
    return map;
  }
}
