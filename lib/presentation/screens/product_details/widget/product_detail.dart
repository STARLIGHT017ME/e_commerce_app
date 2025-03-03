import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/data/model.dart';
import 'package:e_commerce_app/presentation/screens/cart/provider/cart_provider.dart';
import 'package:e_commerce_app/presentation/screens/cart/view_model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetail extends ConsumerStatefulWidget {
  final ECommerceModel product;

  const ProductDetail({super.key, required this.product});

  @override
  ConsumerState<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends ConsumerState<ProductDetail> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite ? 'Added to wishlist' : 'Removed from favorites',
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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

          // Product Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name & Favorite Button
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
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.black,
                          size: 28,
                        ),
                        onPressed: toggleFavorite,
                      ),
                    ],
                  ),

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
                  Text(
                    widget.product.description,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 15),

                  const SizedBox(height: 15),

                  // Color Options
                ],
              ),
            ),
          ),

          // Add to Cart Button
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
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
                  ref.read(cartProvider.notifier).addproduct(cartItem);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${widget.product.title} added to cart'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget for creating size selection chips

  // Widget for color selection circles
}
