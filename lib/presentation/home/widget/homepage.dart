import 'package:e_commerce_app/data/model.dart';
import 'package:e_commerce_app/presentation/home/view_models/homemodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Homepage extends ConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<ECommerceModel>> products =
        ref.watch(productProvider);

    return products.when(
        data: (productList) => ListView.builder(
              itemCount: productList.length,
              itemBuilder: (BuildContext context, int index) {
                final product = productList[index];
                return ListTile(
                  title: Text(product.title),
                  subtitle: Text("\$${product.price}"),
                  leading: Image.network(product.image),
                );
              },
            ),
        error: (err, stack) => Text("Error:$err"),
        loading: () => const CircularProgressIndicator());
  }
}
