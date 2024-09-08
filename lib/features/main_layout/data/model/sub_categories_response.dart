import 'package:ecommerce_app/features/main_layout/data/model/sub_category.dart';

import 'meta_data.dart';

class SubCategoriesResponse {
  SubCategoriesResponse({
    this.results,
    this.metadata,
    this.data,
  });

  SubCategoriesResponse.fromJson(dynamic json) {
    results = json['results'];
    metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(SubCategoryDM.fromJson(v));
      });
    }
  }

  num? results;
  Metadata? metadata;
  List<SubCategoryDM>? data;

  SubCategoriesResponse copyWith({
    num? results,
    Metadata? metadata,
    List<SubCategoryDM>? data,
  }) =>
      SubCategoriesResponse(
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
