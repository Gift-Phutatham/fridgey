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
  final allCategories = getAllCategories();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: SizedBox(
        height: 25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: allCategories.length,
          itemBuilder: (item, index) => GestureDetector(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 11),
              child: Column(
                children: [
                  Text(
                    allCategories[index],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: myIndex == index ? kTextColor1 : kTextColor4,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: kPadding / 4),
                    height: 3,
                    width: 50,
                    color: myIndex == index ? kTextColor1 : Colors.transparent,
                  ),
                ],
              ),
            ),
            onTap: () {
              setState(() {
                myIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
