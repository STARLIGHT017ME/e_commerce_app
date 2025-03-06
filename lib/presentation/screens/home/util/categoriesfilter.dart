import 'package:e_commerce_app/presentation/screens/home/provider/home_provider.dart';
import 'package:flutter/material.dart';

class CategoryFilter extends StatefulWidget {
  final String selectedCategory;
  final ProductNotifier notifier;

  const CategoryFilter(
      {super.key, required this.selectedCategory, required this.notifier});

  @override
  _CategoryFilterState createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = "All";
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      "All",
      ...widget.notifier.uniqueCategories
    ]; // Dynamically fetch categories

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          final isSelected = selectedCategory == category;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = category;
              });
              if (category == "All") {
                widget.notifier.clearFilters();
              } else {
                widget.notifier.filterByCategory(category);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF48D861)
                          : Colors.transparent,
                      border: Border.all(
                        color: Colors.black,
                        width: 1.7,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.white : Colors.black,
                        fontSize: isSelected ? 17 : 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
