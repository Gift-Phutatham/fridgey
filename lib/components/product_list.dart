import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: products.length,
      itemBuilder: (item, index) => GestureDetector(
        child: Row(
          children: <Widget>[
            Image(
              image: AssetImage(getImage(products[index].category)),
              width: 50,
              height: 50,
            ),
            Column(
              children: [
                Text(products[index].productName),
                Text(
                  '${products[index].quantity.toString()} ${products[index].unit}',
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ],
        ),
      ),
    );
  }
}

String getImage(String product) {
  String toReturn = '';
  switch (product) {
    case 'Starch & Grains':
      {
        toReturn = 'assets/starch_grains.png';
      }
      break;
    case 'Fruits & Vegetables':
      {
        toReturn = 'assets/fruits_vegetables.png';
      }
      break;
    case 'Meat & Fish':
      {
        toReturn = 'assets/meat_fish.png';
      }
      break;
    case 'Dairy':
      {
        toReturn = 'assets/dairy.png';
      }
      break;
    case 'Others':
      {
        toReturn = 'assets/others.png';
      }
      break;
  }
  return toReturn;
}
