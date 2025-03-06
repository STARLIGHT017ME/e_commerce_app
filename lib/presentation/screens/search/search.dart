import 'package:e_commerce_app/presentation/screens/home/provider/home_provider.dart';
import 'package:e_commerce_app/presentation/screens/product_details/widget/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productProvider);
    final productNotifier = ref.read(productProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: (value) {
            productNotifier.searchProducts(value);
          },
          decoration: InputDecoration(
            hintText: "Search products...",
            border: InputBorder.none,
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      productNotifier.clearFilters();
                    },
                  )
                : null,
          ),
        ),
      ),
      body: productState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : productState.filteredProducts.isEmpty
              ? const Center(child: Text("No products found"))
              : ListView.builder(
                  itemCount: productState.filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = productState.filteredProducts[index];
                    return ListTile(
                      leading: Image.network(product.image, width: 50),
                      title: Text(product.title),
                      subtitle: Text("\$${product.price}"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetail(product: product),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
