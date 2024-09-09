import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';

class Product {
  Product({
    required this.sold,
    required this.images,
    required this.subcategory,
    required this.ratingsQuantity,
    required this.id,
    required this.title,
    required this.description,
    required this.quantity,
    required this.price,
    required this.imageCover,
    required this.category,
    required this.brand,
    required this.ratingsAverage,
  });

  final num sold;
  final List<String> images;
  final List<Category> subcategory;
  final num ratingsQuantity;
  final String id;
  final String title;
  final String description;
  final num quantity;
  final num price;
  final String imageCover;
  final Category category;
  final Category brand;
  final num ratingsAverage;
}
