import 'meta_data.dart';
import 'product_dm.dart';

class ProductsResponse {
  ProductsResponse({
    this.results,
    this.metadata,
    this.data,
  });

  ProductsResponse.fromJson(dynamic json) {
    results = json['results'];
    metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ProductDM.fromJson(v));
      });
    }
  }

  num? results;
  Metadata? metadata;
  List<ProductDM>? data;

  ProductsResponse copyWith({
    num? results,
    Metadata? metadata,
    List<ProductDM>? data,
  }) =>
      ProductsResponse(
        results: results ?? this.results,
        metadata: metadata ?? this.metadata,
        data: data ?? this.data,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['results'] = results;
    if (metadata != null) {
      map['metadata'] = metadata?.toJson();
    }
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
