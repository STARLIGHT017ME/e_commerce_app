import 'package:e_commerce_app/data/model.dart';
import 'package:e_commerce_app/data/service/api/api_service.dart';

class Respository {
  final ApiService apiRequest;

  Respository(this.apiRequest);

  Future<List<ECommerceModel>> getProducts() async {
    final productList = await apiRequest.fetchProducts();
    return productList.map((json) => ECommerceModel.fromJson(json)).toList();
  }
}
