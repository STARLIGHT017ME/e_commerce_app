import 'dart:convert';
import 'package:e_commerce_app/constraint/app_constraint.dart';
import 'package:http/http.dart' as http;

//ApiService is used to send a get request to the api url to fetch the product
class ApiService {
  final AppConstraint appConstraint;
  ApiService({required this.appConstraint});

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    final String url = appConstraint.baseUrl;
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      return throw ("Failed to fetch products. Status code: ${response.statusCode}");
    }
  }
}
