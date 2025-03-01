import 'package:e_commerce_app/presentation/screens/cart/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Cart extends ConsumerWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back, color: Colors.black)),
          title: const Center(
            child: Text(
              'C a r t',
              style: TextStyle(color: Colors.black, fontSize: 27),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: cartItems.length,
          itemBuilder: (context, index) {
            final item = cartItems[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.network(
                    item.imageUrl,
                    height: 100,
                    width: 100,
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(item.name),
                      subtitle: Text('Price: ${item.price}'),
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
                              content: Text('${item.name} removed from cart'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Text("Total: \$500", style: TextStyle(fontSize: 25)),
              const Spacer(),
              Card(
                  elevation: 2,
                  color: const Color(0xFF48D861),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Add to Cart",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  )),
            ],
          ),
        ));
  }
}
