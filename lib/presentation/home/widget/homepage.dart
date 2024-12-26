import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/data/app_data.dart';
import 'package:e_commerce_app/presentation/home/view_models/homemodel.dart';
import 'package:e_commerce_app/presentation/home/widget/custom_slider.dart';
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
  int currentsliderpage = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

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
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.black)),
                  width: width,
                  padding: EdgeInsets.all(16),
                ),
              ),
              sliderdisplay(
                height,
                width,
              ),
              products.when(
                data: (productList) {
                  return Container();
                },
                error: (err, stack) => Text("Error:$err"),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
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

//automatic carousel sliders
  Widget sliderdisplay(
    double height,
    double width,
  ) {
    return SizedBox(
      height: height * .4, //adjust height of the coursel from the device
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
                viewportFraction: 0.6,
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
