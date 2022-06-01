class StoreList {
  final String title;
  final String image;
  final String category;
  final num price;
  final String description;

  StoreList(
      {required this.title,
      required this.image,
      required this.category,
      required this.price,
      required this.description});
  factory StoreList.fromJson(Map<String, dynamic> json) {
    return StoreList(
        title: json['title'] ?? 'no data',
        image: json['image'] ?? 'no data',
        category: json['category'] ?? 'no data',
        price: json['price'] ?? 0,
        description: json['description'] ?? 'no data');
  }
}
