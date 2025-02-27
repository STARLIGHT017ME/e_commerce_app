import 'package:e_commerce_app/presentation/general_util/customButtomNavigationBar.dart';
import 'package:e_commerce_app/presentation/screens/home/views/homepage.dart';
import 'package:e_commerce_app/presentation/screens/profile/view/profile.dart';
import 'package:e_commerce_app/presentation/screens/search.dart';
import 'package:e_commerce_app/presentation/screens/wishlist/view/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Screendisplay extends ConsumerStatefulWidget {
  const Screendisplay({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScreendisplayState();
}

class _ScreendisplayState extends ConsumerState<Screendisplay>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  final List<Widget> _pages = [
    const Homepage(),
    const Search(),
    const Wishlist(),
    const Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: selectedIndex,
          children: _pages,
        ),
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
            child: Custombuttomnavigationbar(
              currentIndex: selectedIndex,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
          ),
        ));
  }
}
