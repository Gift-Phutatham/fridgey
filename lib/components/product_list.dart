import 'package:flutter/material.dart';

// import 'package:sqflite/sqflite.dart';

import '../models/product.dart';
import '../pages/update_page.dart';
import '../sqflite/database.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late List<Product> products = [];
  late Future<List<Product>> temp;

  @override
  void initState() {
    super.initState();
    refreshProducts();
  }

  void refreshProducts() async {
    setState(() {
      temp = FridgeyDb.instance.readProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: temp,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data.length,
            itemBuilder: (item, index) => GestureDetector(
              child: Container(
                margin:
                    const EdgeInsets.only(top: 5.0, bottom: 5.0, right: 3.0),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image(
                          image: AssetImage(
                              getImage(snapshot.data[index].category)),
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(width: 10.0),
                        Column(
                          children: <Widget>[
                            Text(
                              snapshot.data[index].productName,
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              '${snapshot.data[index].quantity.toString()} ${snapshot.data[index].unit}',
                            )
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ],
                    ),
                    const Image(
                      image: AssetImage('assets/next.png'),
                      width: 20,
                      height: 20,
                    ),
                  ],
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UpdatePage()),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
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

// import 'package:flutter/material.dart';
// import 'package:fridgey/pages/update_page.dart';
//
// import '../models/product.dart';
// import '../pages/update_page.dart';
//
// class ProductList extends StatefulWidget {
//   const ProductList({Key? key}) : super(key: key);
//
//   @override
//   State<ProductList> createState() => _ProductListState();
// }
//
// class _ProductListState extends State<ProductList> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       scrollDirection: Axis.vertical,
//       itemCount: products.length,
//       itemBuilder: (item, index) => GestureDetector(
//         child: Container(
//           margin: const EdgeInsets.only(top: 5.0, bottom: 5.0, right: 3.0),
//           padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Row(
//                 children: <Widget>[
//                   Image(
//                     image: AssetImage(getImage(products[index].category)),
//                     width: 50,
//                     height: 50,
//                   ),
//                   const SizedBox(width: 10.0),
//                   Column(
//                     children: <Widget>[
//                       Text(
//                         products[index].productName,
//                       ),
//                       const SizedBox(height: 5.0),
//                       Text(
//                         '${products[index].quantity.toString()} ${products[index].unit}',
//                       )
//                     ],
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                   ),
//                 ],
//               ),
//               const Image(
//                 image: AssetImage('assets/next.png'),
//                 width: 20,
//                 height: 20,
//               ),
//             ],
//           ),
//         ),
//         onTap: () => Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => const UpdatePage()),
//         ),
//       ),
//     );
//   }
// }
//
// String getImage(String product) {
//   String toReturn = '';
//   switch (product) {
//     case 'Starch & Grains':
//       {
//         toReturn = 'assets/starch_grains.png';
//       }
//       break;
//     case 'Fruits & Vegetables':
//       {
//         toReturn = 'assets/fruits_vegetables.png';
//       }
//       break;
//     case 'Meat & Fish':
//       {
//         toReturn = 'assets/meat_fish.png';
//       }
//       break;
//     case 'Dairy':
//       {
//         toReturn = 'assets/dairy.png';
//       }
//       break;
//     case 'Others':
//       {
//         toReturn = 'assets/others.png';
//       }
//       break;
//   }
//   return toReturn;
// }
