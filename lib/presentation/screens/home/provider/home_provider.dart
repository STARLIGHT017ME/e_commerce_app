import 'package:e_commerce_app/presentation/screens/home/view_models/home_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:e_commerce_app/data/respository/respository.dart';
import 'package:e_commerce_app/presentation/provider/provider.dart';

class ProductNotifier extends StateNotifier<ProductState> {
  final Respository repository;

  ProductNotifier({required this.repository}) : super(const ProductState()) {
    fetchProducts(); // Fetch products on initialization
  }

  Future<void> fetchProducts() async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);
      final products = await repository.getProducts();

      state = state.copyWith(
          allProducts: products, filteredProducts: products, isLoading: false);

      print("Fetching");
      print("fetched product : $state");
    } catch (error) {
      state = state.copyWith(isLoading: false, errorMessage: error.toString());
      print("fetched product error : $state");
    }
  }

  String mapCategory(String category) {
    switch (category.toLowerCase()) {
      case "men's clothing":
        return "Men";
      case "women's clothing":
        return "Women";
      case "jewelery":
        return "Jewelery";
      case "electronics":
        return "Electronics";
      default:
        return category; // Use the original name if no mapping exists
    }
  }

  // Compute unique categories && Provide a list of unique, user-friendly categories for the UI to display.
  List<String> get uniqueCategories {
    return state.allProducts
        .map((product) => mapCategory(product.category)) // Map raw categories
        .toSet() //removes duplicates
        .toList(); // Convert back to a list
  }

  void filterByCategory(String category) {
    final filtered = state.allProducts
        .where((product) => mapCategory(product.category) == category)
        .toList();
    state =
        state.copyWith(filteredProducts: filtered, selectedCategory: category);
    print("Fetching");
    print("filterByCategory : $state");
  }

  void searchProducts(String query) {
    final filtered = state.allProducts
        .where((product) =>
            product.title.toLowerCase().contains(query.toLowerCase()) &&
            (state.selectedCategory.isEmpty ||
                mapCategory(product.category) == state.selectedCategory))
        .toList();
    state = state.copyWith(filteredProducts: filtered, searchQuery: query);
    print("Fetching");
    print("searchProducts : $state");
  }

  void clearFilters() {
    state = state.copyWith(
        filteredProducts: state.allProducts,
        selectedCategory: '',
        searchQuery: '');
  }
}

final productProvider = StateNotifierProvider<ProductNotifier, ProductState>(
  (ref) => ProductNotifier(repository: ref.read(repositoryProvider)),
);
