import 'dart:convert';
import 'package:e_commerce_app/constraint/app_constraint.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final AppConstraint appConstraint;
  ApiService({required this.appConstraint});

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    final String url = appConstraint.baseUrl;
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return json.decode(response.body);
    } else {
      throw ("An error occurred");
    }
  }
}
