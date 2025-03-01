import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/data/model.dart';
import 'package:e_commerce_app/presentation/screens/cart/provider/cart_provider.dart';
import 'package:e_commerce_app/presentation/screens/cart/view_model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetail extends ConsumerWidget {
  final ECommerceModel product;

  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Correctly pop the page
        ),
        title: const Center(
          child: Text(
            "D e t a i l s",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.favorite_border_outlined,
              color: Colors.black,
              size: 25,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                color: Colors.white,
                elevation: 2,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                    fit: BoxFit.contain,
                    width: size.width,
                    height: size.height * 0.4,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
            ),

            // Description Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(Icons.star,
                          color: Color.fromRGBO(255, 215, 0, 6)),
                      const SizedBox(width: 5),
                      Text(
                        "${product.ratings.rate}",
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          " ${product.title}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 3,
                            fontSize: 17,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "\$${product.price} ",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
        child: Row(children: [
          Expanded(
            flex: 1,
            child: Text(
              "\$${product.price}",
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                final cartItem = CartModel(
                    id: product.id.toString(),
                    name: product.title,
                    price: product.price.toString(),
                    imageUrl: product.image);
                ref.read(cartProvider.notifier).addproduct(cartItem);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.title} added to cart'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: Card(
                  elevation: 2,
                  color: const Color(0xFF48D861),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text(
                      "Add to Cart",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  )),
            ),
          ),
        ]),
      ),
    );
  }
}
