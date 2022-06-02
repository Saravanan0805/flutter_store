class StoreList {
  final String title;
  final String image;
  final String category;
  final num price;
  final String description;
  final ItemRating rating;

  StoreList(
      {required this.title,
      required this.image,
      required this.category,
      required this.price,
      required this.description,
      required this.rating});
  factory StoreList.fromJson(Map<String, dynamic> json) {
    return StoreList(
        title: json['title'] ?? 'no data',
        image: json['image'] ?? 'no data',
        category: json['category'] ?? 'no data',
        price: json['price'] ?? 0,
        description: json['description'] ?? 'no data',
        rating: ItemRating.fromJson(json['rating']));
  }
}

class ItemRating {
  final num rate;
  final num count;

  ItemRating({
    required this.rate,
    required this.count,
  });
  factory ItemRating.fromJson(Map<String, dynamic> json) {
    return ItemRating(rate: json['rate'] ?? 0, count: json['count'] ?? 0);
  }
}
