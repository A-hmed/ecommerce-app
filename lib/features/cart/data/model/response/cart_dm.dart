import 'cart_product_dm.dart';

class CartDM {
  CartDM({
    this.id,
    this.cartOwner,
    this.products,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.totalCartPrice,
  });

  CartDM.fromJson(dynamic json) {
    id = json['_id'];
    cartOwner = json['cartOwner'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(CartProductDM.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    totalCartPrice = json['totalCartPrice'];
  }

  String? id;
  String? cartOwner;
  List<CartProductDM>? products;
  String? createdAt;
  String? updatedAt;
  num? v;
  num? totalCartPrice;

  CartDM copyWith({
    String? id,
    String? cartOwner,
    List<CartProductDM>? products,
    String? createdAt,
    String? updatedAt,
    num? v,
    num? totalCartPrice,
  }) =>
      CartDM(
        id: id ?? this.id,
        cartOwner: cartOwner ?? this.cartOwner,
        products: products ?? this.products,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
        totalCartPrice: totalCartPrice ?? this.totalCartPrice,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['cartOwner'] = cartOwner;
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    map['totalCartPrice'] = totalCartPrice;
    return map;
  }
}
