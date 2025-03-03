import 'package:e_commerce_app/presentation/screens/cart/view_model/cart_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartProvider extends StateNotifier<List<CartModel>> {
  CartProvider() : super([]);

  void addproduct(CartModel product) {
    bool productExist = state.any((item) => item.id == product.id);

    if (productExist) {
      state = state.map((item) {
        if (item.id == product.id) {
          return item.copyWith(quantity: item.quantity + 1);
        }
        return item;
      }).toList();
    } else {
      state = [...state, product];
    }
  }

  void decreaseProduct(String id) {
    state = state
        .map(
          (item) {
            if (item.id == id) {
              if (item.quantity > 1) {
                return item.copyWith(quantity: item.quantity - 1);
              } else {
                return null;
              }
            } else {
              return item;
            }
          },
        )
        .whereType<CartModel>()
        .toList();
  }

  void removeProduct(String id) {
    state = state.where((item) => item.id != id).toList();
  }
}

final cartProvider =
    StateNotifierProvider<CartProvider, List<CartModel>>((ref) {
  return CartProvider();
});
