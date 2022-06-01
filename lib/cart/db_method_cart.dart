import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'db_class_cart.dart';

class HttpService {
  Future<List<CartProducts>> getCart(String url) async {
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> value = json.decode(response.body);
      List<dynamic> products = value['products'];

      /// print(value);
      print(url);
      List<CartProducts> items = products
          .map(
            (item) => CartProducts.fromJson(item),
          )
          .toList();

      return items; // json data from server decoded and returned as a list
    } else {
      throw Exception('failed to load');
    }
  }
}
