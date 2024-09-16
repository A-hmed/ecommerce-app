import 'package:ecommerce_app/features/main_layout/domain/model/category.dart';

class Product {
  Product({
    required this.sold,
    required this.images,
    required this.subCategories,
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
    this.totalCartPrice = 0,
    this.totalItemsInCart = 0,
  });

  final num sold;
  final List<String> images;
  final List<Category> subCategories;
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
  final num totalCartPrice;
  final num totalItemsInCart;
}
