import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/presentation/screens/wishlist/provider/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Wishlist extends ConsumerWidget {
  const Wishlist({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistItems = ref.watch(wishlistprovider);
    return Scaffold(
      body: wishlistItems.isEmpty
          ? const Center(
              child: Text(
                'No items in Wishlist',
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: wishlistItems.length,
              itemBuilder: (BuildContext context, int index) {
                final item = wishlistItems[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
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
                                  .read(wishlistprovider.notifier)
                                  .removeproduct(item.id);
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
                    ],
                  ),
                );
              },
            ),
    );
  }
}
