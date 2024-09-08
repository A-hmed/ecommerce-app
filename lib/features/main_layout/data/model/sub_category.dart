class SubCategoryDM {
  SubCategoryDM({
    this.id,
    this.name,
    this.slug,
    this.category,
  });

  SubCategoryDM.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    category = json['category'];
  }

  String? id;
  String? name;
  String? slug;
  String? category;

  SubCategoryDM copyWith({
    String? id,
    String? name,
    String? slug,
    String? category,
  }) =>
      SubCategoryDM(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        category: category ?? this.category,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['category'] = category;
    return map;
  }
}
