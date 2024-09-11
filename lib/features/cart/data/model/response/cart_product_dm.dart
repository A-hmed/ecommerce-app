import 'package:ecommerce_app/features/main_layout/data/model/product_dm.dart';

class CartProductDM {
  CartProductDM({
    this.numberOfItemsInCart,
    this.id,
    this.product,
    this.totalPriceInCart,
  });

  CartProductDM.fromJson(dynamic json) {
    numberOfItemsInCart = json['count'];
    id = json['_id'];
    product =
        json['product'] != null ? ProductDM.fromJson(json['product']) : null;
    totalPriceInCart = json['price'];
  }

  num? numberOfItemsInCart;
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
        numberOfItemsInCart: count ?? this.numberOfItemsInCart,
        id: id ?? this.id,
        product: product ?? this.product,
        totalPriceInCart: price ?? this.totalPriceInCart,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = numberOfItemsInCart;
    map['_id'] = id;
    if (product != null) {
      map['product'] = product?.toJson();
    }
    map['price'] = totalPriceInCart;
    return map;
  }
}
