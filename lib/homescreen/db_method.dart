import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_store/homescreen/db_class.dart';

class HttpService {
  Future<List<StoreList>> getProducts(String url) async {
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      List<dynamic> value = json.decode(response.body);

      /// print(value);
      print(url);
      List<StoreList> items = value
          .map(
            (item) => StoreList.fromJson(item),
          )
          .toList();

      return items; // json data from server decoded and returned as a list
    } else {
      throw Exception('failed to load');
    }
  }
}
