import 'package:e_commerce_app/data/model.dart';
import 'package:e_commerce_app/data/service/api/api_service.dart';

/* 
The Respository acts as a bridge between the raw API service (ApiService) and your app's logic.
It uses ApiService to fetch raw data from the API and transforms it into domain models (like ECommerceModel).
 */
class Respository {
  final ApiService apiRequest;

  Respository(this.apiRequest);

  Future<List<ECommerceModel>> getProducts() async {
    final productList = await apiRequest.fetchProducts();
    return productList.map((json) => ECommerceModel.fromJson(json)).toList();
  }
}
