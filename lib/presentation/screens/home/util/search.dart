//search bar
import 'package:e_commerce_app/presentation/screens/home/view_models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

TextEditingController searchController = TextEditingController();

Widget searchBar(ProductNotifier notifier) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 20,
    ),
    child: TextField(
      onChanged: (value) => notifier.searchProducts(value),
      controller: searchController,
      decoration: InputDecoration(
        fillColor: const Color.fromRGBO(233, 233, 233, 3),
        hintText: " Search products ......",
        prefixIcon: GestureDetector(
          child: const Padding(
            padding: EdgeInsets.only(left: 6.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FaIcon(
                FontAwesomeIcons.magnifyingGlass,
              ),
            ),
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
