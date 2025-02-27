import 'package:e_commerce_app/presentation/screens/search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Custombuttomnavigationbar extends StatelessWidget {
  final int currentIndex;
  final Function(dynamic index) onTap;
  const Custombuttomnavigationbar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: const Color(0xFF48D861),
      unselectedItemColor: Colors.black,
      currentIndex: currentIndex,
      onTap: onTap,
      items: <BottomNavigationBarItem>[
        const BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.house,
            ),
            label: 'Home'),
        BottomNavigationBarItem(
          icon: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Search(),
                ),
              );
            },
            child: const FaIcon(
              FontAwesomeIcons.magnifyingGlass,
            ),
          ),
          label: 'Search',
        ),
        const BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.heart,
            ),
            label: 'Wishlist'),
        const BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.user,
            ),
            label: 'Profile'),
      ],
    );
  }
}
