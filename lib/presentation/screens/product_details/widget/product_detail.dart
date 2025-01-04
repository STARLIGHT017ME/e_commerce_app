import 'package:e_commerce_app/data/model.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  final ECommerceModel product;

  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Image.network(product.image),
            Text(product.title),
            Text(product.description),
            Row(
              children: [
                Text(product.price.toString()),
                TextButton(
                  onPressed: () {},
                  child: const Text("Add to cart"),
                ),
                Text(product.ratings.rate.toString())
              ],
            )
          ],
        ),
      ),
    );
  }
}
