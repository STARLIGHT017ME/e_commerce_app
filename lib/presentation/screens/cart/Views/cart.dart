import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/presentation/screens/cart/provider/cart_provider.dart';
import 'package:e_commerce_app/presentation/screens/home/provider/home_provider.dart';
import 'package:e_commerce_app/presentation/screens/product_details/widget/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Cart extends ConsumerWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final productState = ref.watch(productProvider);
    double totalPrice = cartItems.fold(
        0, (sum, item) => sum + (double.parse(item.price) * item.quantity));
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Center(
          child: Text(
            'My Cart',
            style: TextStyle(color: Colors.black, fontSize: 27),
          ),
        ),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                'No items in cart',
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      try {
                        final product = productState.allProducts.firstWhere(
                          (productdetails) =>
                              productdetails.id.toString() == item.id,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetail(
                              product: product,
                            ),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Product not found'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl: item.imageUrl,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          height: 100,
                          width: 100,
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(item.name),
                            subtitle: Text('Price: \$${item.price}'),
                            trailing: IconButton(
                              icon: const FaIcon(
                                FontAwesomeIcons.trash,
                                color: Color.fromRGBO(186, 12, 47, 1),
                                size: 20,
                              ),
                              onPressed: () {
                                ref
                                    .read(cartProvider.notifier)
                                    .removeProduct(item.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('${item.name} removed from cart'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                ref
                                    .read(cartProvider.notifier)
                                    .addproduct(item);
                              },
                              icon: const Icon(Icons.add_circle_outline),
                            ),
                            Text(
                              '${item.quantity}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: () {
                                ref
                                    .read(cartProvider.notifier)
                                    .decreaseProduct(item.id);
                              },
                              icon: const Icon(Icons.remove_circle_outline),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
            elevation: 2,
            color: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Checkout for \$$totalPrice",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 25),
              ),
            )),
      ),
    );
  }
}
