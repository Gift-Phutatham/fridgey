import 'package:flutter/material.dart';

import '../constants.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = [
    "All",
    "Starch & Grains",
    "Fruits & Vegetables",
    "Meat & Fish",
    "Dairy",
    "Others",
  ];
  int myIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (item, index) => GestureDetector(
          child: Container(
            child: Column(
              children: [
                Text(
                  categories[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kDarkTextColor,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: kPadding / 4),
                  height: 3,
                  width: 50,
                  color: myIndex == index ? Colors.black : Colors.transparent,
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: kPadding / 2),
          ),
          onTap: () {
            setState(() {
              myIndex = index;
            });
          },
        ),
      ),
    );
  }
}
