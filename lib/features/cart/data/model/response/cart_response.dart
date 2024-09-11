import 'cart_dm.dart';

class CartResponse {
  CartResponse({
    this.status,
    this.numOfCartItems,
    this.cartId,
    this.cart,
  });

  CartResponse.fromJson(dynamic json) {
    status = json['status'];
    numOfCartItems = json['numOfCartItems'];
    cartId = json['cartId'];
    cart = json['data'] != null ? CartDM.fromJson(json['data']) : null;
  }

  String? status;
  num? numOfCartItems;
  String? cartId;
  CartDM? cart;

  CartResponse copyWith({
    String? status,
    num? numOfCartItems,
    String? cartId,
    CartDM? data,
  }) =>
      CartResponse(
        status: status ?? this.status,
        numOfCartItems: numOfCartItems ?? this.numOfCartItems,
        cartId: cartId ?? this.cartId,
        cart: data ?? this.cart,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['numOfCartItems'] = numOfCartItems;
    map['cartId'] = cartId;
    if (cart != null) {
      map['data'] = cart?.toJson();
    }
    return map;
  }
}
