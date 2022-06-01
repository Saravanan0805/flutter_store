// ignore_for_file: file_names

class CartProducts {
  //final String date;
  final num productsId;
  final num quantity;

  CartProducts({
    required this.productsId,
    required this.quantity,
  });
  factory CartProducts.fromJson(Map<String, dynamic> json) {
    return CartProducts(
        // date: json['date'] as String,
        productsId: json['productId'],
        quantity: json['quantity']);
  }
}
