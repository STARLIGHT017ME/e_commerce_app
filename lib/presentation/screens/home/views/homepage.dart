import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/data/app_data.dart';
import 'package:e_commerce_app/presentation/screens/cart/Views/cart.dart';
import 'package:e_commerce_app/presentation/screens/home/provider/home_provider.dart';
import 'package:e_commerce_app/presentation/screens/home/util/categoriesfilter.dart';
import 'package:e_commerce_app/presentation/screens/home/util/productcard.dart';
import 'package:e_commerce_app/presentation/screens/home/util/custom_slider.dart';
import 'package:e_commerce_app/presentation/screens/product_details/widget/product_detail.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  int selectedCategories = 0;

  int currentsliderpage = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  TextEditingController searchController = TextEditingController();

  late CarouselSliderController sliderCarouselController;
  @override
  void initState() {
    sliderCarouselController = CarouselSliderController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productProvider);
    final productNotifier = ref.watch(productProvider.notifier);

    Size size;
    double height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: productState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : productState.errorMessage != null
              ? Text("Error: ${productState.errorMessage}")
              : CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      pinned: true,
                      title: const Text(
                        "Discover",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.shopping_cart),
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Cart(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          sliderdisplay(height, width),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  "Categories",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CategoryFilter(
                              selectedCategory: productState.selectedCategory,
                              notifier: productNotifier)
                        ],
                      ),
                    ),
                    SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final product = productState.filteredProducts[index];

                          return productCard(
                            product.image,
                            product.title,
                            product.price.toString(),
                            product.ratings.rate.toString(),
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetail(product: product),
                              ),
                            ),
                          );
                        },
                        childCount: productState.filteredProducts.length,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 6,
                      ),
                    )
                  ],
                ),
    );
  }

  //cards to be displayed in the categories section
  Widget displayCard(String image) {
    return Column(
      children: [
        Container(
          height: 180,
          width: 160,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(233, 233, 233, 3),
              borderRadius: BorderRadius.circular(15)),
          child: Image.network(image),
        )
      ],
    );
  }

//automatic carousel sliders
  Widget sliderdisplay(
    double height,
    double width,
  ) {
    return SizedBox(
      height: height * .3, //adjust height of the coursel from the device
      width: width / 0.6,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: CarouselSlider(
              carouselController: sliderCarouselController,
              items: Appdata.sliders.map((imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    /// Custom Image Viewer widget
                    return CustomSlider.show(
                        context: context, url: imagePath, fit: BoxFit.contain);
                  },
                );
              }).toList(),
              options: CarouselOptions(
                aspectRatio: 2,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
                onPageChanged: (index, reason) {
                  setState(
                    () {
                      currentsliderpage = index;
                    },
                  );
                },
              ),
            ),
          ),

          //indicator for carousel
          Positioned(
            bottom: height * .05, //adjust the indicator placement
            child: Row(
              children: List.generate(
                Appdata.sliders.length,
                (index) {
                  bool isSelected = currentsliderpage == index;
                  return GestureDetector(
                    onTap: () {
                      sliderCarouselController.jumpToPage(index);
                    },
                    child: AnimatedContainer(
                      //adjust the size of the containers
                      width: isSelected ? 15 : 7,

                      height: 7,
                      margin:
                          EdgeInsets.symmetric(horizontal: isSelected ? 6 : 3),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color.fromRGBO(119, 87, 62, 7)
                            : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(
                          40,
                        ),
                      ),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
