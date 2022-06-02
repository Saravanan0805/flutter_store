import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'db_class_account.dart';

class HttpService {
  Future<List<UserDetails>> getUserDetails(String url) async {
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      List<dynamic> value = [data];
      print(value);
      List<UserDetails> items = value
          .map(
            (item) => UserDetails.fromJson(item),
          )
          .toList();

      return items; // json data from server decoded and returned as a list
    } else {
      throw Exception('failed to load');
    }
  }
}
