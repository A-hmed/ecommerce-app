class Category {
  Category({
    required this.id,
    required this.name,
    required this.image,
  });

  Category.empty() {
    id = "";
    name = "";
    image = "";
  }

  late String id;
  late String name;
  late String image;
}
