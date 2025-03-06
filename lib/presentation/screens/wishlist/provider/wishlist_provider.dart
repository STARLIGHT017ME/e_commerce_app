import 'package:e_commerce_app/presentation/screens/wishlist/viewmodel/wishlist_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistProvider extends StateNotifier<List<WishlistModel>> {
  WishlistProvider() : super([]);

  void addProduct(WishlistModel product) {
    bool exist = state.any((item) => item.id == product.id);
    if (!exist) {
      state = [...state, product];
    }
  }

  void removeproduct(String id) {
    state = state.where((item) => item.id != id).toList();
  }
}

final wishlistprovider =
    StateNotifierProvider<WishlistProvider, List<WishlistModel>>((ref) {
  return WishlistProvider();
});
