import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/product.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int myIndex = 0;

  @override
  Widget build(BuildContext context) {
    final allCategories = getAllCategories();
    return SizedBox(
      height: 25,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: allCategories.length,
        itemBuilder: (item, index) => GestureDetector(
          child: Container(
            child: Column(
              children: [
                Text(
                  allCategories[index],
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
