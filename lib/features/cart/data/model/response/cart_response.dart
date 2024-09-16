import 'cart_dm.dart';

class CartResponse {
  CartResponse({
    this.status,
    this.numOfCartItems,
    this.cartId,
    this.cartDm,
  });

  CartResponse.fromJson(dynamic json) {
    status = json['status'];
    numOfCartItems = json['numOfCartItems'];
    cartId = json['cartId'];
    cartDm = json['data'] != null ? CartDM.fromJson(json['data']) : null;
  }

  String? status;
  num? numOfCartItems;
  String? cartId;
  CartDM? cartDm;

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
        cartDm: data ?? this.cartDm,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['numOfCartItems'] = numOfCartItems;
    map['cartId'] = cartId;
    if (cartDm != null) {
      map['data'] = cartDm?.toJson();
    }
    return map;
  }
}
