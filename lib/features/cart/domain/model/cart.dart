import 'package:ecommerce_app/features/main_layout/domain/model/product.dart';

class Cart {
  List<Product> products;
  double totalPrice;

  Cart({required this.products, required this.totalPrice});
}
