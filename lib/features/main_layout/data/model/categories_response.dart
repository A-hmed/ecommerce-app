import 'category_dm.dart';
import 'meta_data.dart';

class CategoriesResponse {
  CategoriesResponse({
    this.results,
    this.metadata,
    this.data,
  });

  CategoriesResponse.fromJson(dynamic json) {
    results = json['results'];
    metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CategoryDM.fromJson(v));
      });
    }
  }

  num? results;
  Metadata? metadata;
  List<CategoryDM>? data;

  CategoriesResponse copyWith({
    num? results,
    Metadata? metadata,
    List<CategoryDM>? data,
  }) =>
      CategoriesResponse(
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
