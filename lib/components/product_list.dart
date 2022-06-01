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
        child: Container(
          margin: const EdgeInsets.only(top: 5.0, bottom: 5.0, right: 10.0),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image(
                    image: AssetImage(getImage(products[index].category)),
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(width: 10.0),
                  Column(
                    children: <Widget>[
                      Text(
                        products[index].productName,
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        '${products[index].quantity.toString()} ${products[index].unit}',
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: const [
                      Image(
                        image: AssetImage('assets/delete.png'),
                        width: 10,
                        height: 10,
                      ),
                      Image(
                        image: AssetImage('assets/update.png'),
                        width: 10,
                        height: 10,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
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
