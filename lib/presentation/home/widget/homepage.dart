import 'package:e_commerce_app/presentation/home/view_models/homemodel.dart';
import 'package:e_commerce_app/presentation/product_details/widget/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  int selectedIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider);

    return SafeArea(
      child: Scaffold(
        body: products.when(
          data: (productList) => ListView.builder(
            itemCount: productList.length,
            itemBuilder: (BuildContext context, int index) {
              final product = productList[index];
              return ListTile(
                title: Text(product.title),
                subtitle: Text("\$${product.price}"),
                leading: Image.network(product.image),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetail(product: product),
                  ),
                ),
              );
            },
          ),
          error: (err, stack) => Text("Error:$err"),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(bottom: 5, left: 10, right: 10),
          decoration: const BoxDecoration(
            color: Colors.transparent,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 30,
                offset: Offset(0, 20),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
                backgroundColor: Colors.grey,
                selectedItemColor: const Color.fromRGBO(119, 87, 62, 7),
                unselectedItemColor: Colors.black,
                currentIndex: selectedIndex,
                onTap: onItemTapped,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: FaIcon(
                        FontAwesomeIcons.house,
                      ),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      icon: FaIcon(
                        FontAwesomeIcons.magnifyingGlass,
                      ),
                      label: 'Search'),
                  BottomNavigationBarItem(
                      icon: FaIcon(
                        FontAwesomeIcons.user,
                      ),
                      label: 'Profile'),
                  BottomNavigationBarItem(
                      icon: FaIcon(
                        FontAwesomeIcons.cartShopping,
                      ),
                      label: 'Cart'),
                ]),
          ),
        ),
      ),
    );
  }
}
