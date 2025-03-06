import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/data/model.dart';
import 'package:e_commerce_app/presentation/screens/cart/provider/cart_provider.dart';
import 'package:e_commerce_app/presentation/screens/cart/view_model/cart_model.dart';
import 'package:e_commerce_app/presentation/screens/home/views/homepage.dart';
import 'package:e_commerce_app/presentation/screens/wishlist/provider/wishlist_provider.dart';
import 'package:e_commerce_app/presentation/screens/wishlist/viewmodel/wishlist_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetail extends ConsumerStatefulWidget {
  final ECommerceModel product;

  const ProductDetail({super.key, required this.product});

  @override
  ConsumerState<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends ConsumerState<ProductDetail> {
  @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final wishlist = ref.watch(wishlistprovider);
    final isFavorite =
        wishlist.any((item) => item.id == widget.product.id.toString());

    final cart = ref.watch(cartProvider);
    final isProductIncart = cart.firstWhere(
      (item) => item.id == widget.product.id.toString(),
      orElse: () => const CartModel(
          id: '-1', name: '', price: '', imageUrl: '', quantity: 0),
    );

    return Scaffold(
      body: Stack(
        children: [
          // Scrollable Content
          SingleChildScrollView(
            padding: const EdgeInsets.only(
                bottom:
                    80), // Ensure content does not overlap with the bottom bar
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image Section
                Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.product.image,
                      fit: BoxFit.contain,
                      width: size.width,
                      height: size.height * 0.5,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                    Positioned(
                      top: 40,
                      left: 15,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back,
                            color: Colors.black, size: 28),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),

                // Product Details
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Title & Wishlist Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              widget.product.title.toLowerCase(),
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -1,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.black,
                              size: 28,
                            ),
                            onPressed: () {
                              if (isFavorite) {
                                ref
                                    .read(wishlistprovider.notifier)
                                    .removeproduct(
                                        widget.product.id.toString());
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Removed from wishlist'),
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              } else {
                                ref
                                    .read(wishlistprovider.notifier)
                                    .addProduct(WishlistModel(
                                      id: widget.product.id.toString(),
                                      name: widget.product.title,
                                      price: widget.product.price,
                                      imageUrl: widget.product.image,
                                    ));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Added to wishlist'),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Price
                      Text(
                        "\$${widget.product.price}",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Description
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "description ",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade800),
                        ),
                      ),
                      Text(
                        widget.product.description,
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade700),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Fixed Bottom Section
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              color: Colors.white, // Ensure background color for visibility
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Homepage()),
                      (route) => false,
                    ),
                    icon: const Icon(Icons.home_rounded,
                        color: Colors.black, size: 42),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: size.width * 0.7,
                    height: 60,
                    child: isProductIncart.id == '-1'
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {
                              final cartItem = CartModel(
                                quantity: 1,
                                id: widget.product.id.toString(),
                                name: widget.product.title,
                                price: widget.product.price.toString(),
                                imageUrl: widget.product.image,
                              );
                              ref
                                  .read(cartProvider.notifier)
                                  .addproduct(cartItem);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Added to cart'),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            child: const Text(
                              "Add to Cart",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  ref
                                      .read(cartProvider.notifier)
                                      .decreaseProduct(
                                          widget.product.id.toString());
                                },
                                icon: const Icon(Icons.remove_circle_outline,
                                    size: 25),
                              ),
                              Text(
                                "${isProductIncart.quantity}",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                onPressed: () {
                                  ref.read(cartProvider.notifier).addproduct(
                                        isProductIncart.copyWith(
                                            quantity:
                                                isProductIncart.quantity + 1),
                                      );
                                },
                                icon: const Icon(Icons.add_circle_outline,
                                    size: 25),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

  // Widget for creating size selection chips

  // Widget for color selection circles

