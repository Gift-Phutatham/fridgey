import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = [
    "All",
    "Vegetables",
    "Fruits",
    "Grains",
    "Meat",
    "Dairy",
    "Others",
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) => Text(categories[index]),
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  // Widget buildCategory(int index) {
  //   return Text(
  //     categories[index],
  //   );
  // }
}
