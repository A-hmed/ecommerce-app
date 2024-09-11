class Product {
  final String id;
  final String image;
  final String title;
  final double price;
  final String description;
  final double priceBeforeDiscount;
  final double rating;
  final double totalPriceInCart;
  final int numberOfItemsInCart;

  Product({required this.id,
      required this.image,
    required this.title,
    required this.price,
    required this.description,
    required this.priceBeforeDiscount,
    required this.rating,
      this.totalPriceInCart = 0,
      this.numberOfItemsInCart = 0});
}
