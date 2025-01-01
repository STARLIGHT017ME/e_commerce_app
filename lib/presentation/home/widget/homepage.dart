import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/data/app_data.dart';
import 'package:e_commerce_app/presentation/home/view_models/homemodel.dart';
import 'package:e_commerce_app/presentation/home/widget/custom_slider.dart';
import 'package:e_commerce_app/presentation/product_details/widget/product_detail.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    final products = ref.watch(productProvider);

    Size size;
    double height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return SafeArea(
      child: Scaffold(
        body: products.when(
          data: (productList) {
            final categories = productList
                .map((categories) => categories.category)
                .toSet()
                .map((category) => mapCategory(category))
                .toList();
            return CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: searchBar(),
                      ),
                      sliderdisplay(height, width),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: category(categories),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = productList[index];

                      return ListTile(
                        title: Text(product.title),
                        subtitle: Text("\$${product.price}"),
                        leading: CachedNetworkImage(
                          imageUrl: product.image,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetail(product: product),
                          ),
                        ),
                      );
                    },
                    childCount: productList.length,
                  ),
                )
              ],
            );
          },
          error: (error, stackTrace) => SliverToBoxAdapter(
            child: Text("Error : $error"),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        //bottom navigation bar
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
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
                      FontAwesomeIcons.cartShopping,
                    ),
                    label: 'Cart'),
                BottomNavigationBarItem(
                    icon: FaIcon(
                      FontAwesomeIcons.heart,
                    ),
                    label: 'Wishlist'),
                BottomNavigationBarItem(
                    icon: FaIcon(
                      FontAwesomeIcons.user,
                    ),
                    label: 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Map categories to standardized names
  String mapCategory(String category) {
    switch (category.toLowerCase()) {
      case "men's clothing":
        return "Men";
      case "women's clothing":
        return "Women";
      default:
        return category;
    }
  }

  //categories

  Widget category(List<String> categories) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return buildCategories(index, categories);
        },
      ),
    );
  }

  Widget buildCategories(int indexs, List<String> categories) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          setState(() {
            selectedCategories = indexs;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                categories[indexs],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                height: 2,
                width: 30,
                color: selectedCategories == indexs
                    ? Colors.black
                    : Colors.transparent,
              )
            ],
          ),
        ),
      );
    });
  }

//search bar
  Widget searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          fillColor: const Color.fromRGBO(233, 233, 233, 3),
          hintText: "Search",
          prefixIcon: GestureDetector(
            child: const FaIcon(
              FontAwesomeIcons.magnifyingGlass,
            ),
            onTap: () {},
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  //cards to be displayed

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
