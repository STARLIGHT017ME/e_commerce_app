import 'package:e_commerce_app/presentation/screens/cart/view_model/cart_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartProvider extends StateNotifier<List<CartModel>> {
  CartProvider() : super([]);

  void addproduct(CartModel product) {
    state = [...state, product];
  }

  void removeProduct(String id) {
    state = state.where((item) => item.id != id).toList();
  }
}

final cartProvider =
    StateNotifierProvider<CartProvider, List<CartModel>>((ref) {
  return CartProvider();
});
