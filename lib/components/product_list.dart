import 'package:flutter/material.dart';

import '../constants.dart';
import '../database/product_model.dart';
import '../database/sqflite.dart';
import '../pages/update_page.dart';

/// List all the My Fridge products
class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  static const padding = 20.0;

  int myIndex = 0;

  late Future<List<Product>> products;

  final allCategories = getAllCategories();

  @override
  void initState() {
    super.initState();
    setState(() {
      /// Get the list from database
      products = FridgeyDb.instance.readProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: SizedBox(
            height: 25,

            /// Category menu
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: allCategories.length,
              itemBuilder: (item, index) => GestureDetector(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 11),
                  child: Column(
                    children: <Widget>[
                      Text(
                        allCategories[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: myIndex == index ? kTextColor1 : kTextColor4,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: padding / 4),
                        height: 3,
                        width: 50,
                        color:
                            myIndex == index ? kTextColor1 : Colors.transparent,
                      ),
                    ],
                  ),
                ),
                onTap: () async {
                  if (allCategories[index] != 'All') {
                    products = FridgeyDb.instance
                        .getProductsByCategory(allCategories[index]);
                  } else {
                    products = FridgeyDb.instance.readProducts();
                  }
                  setState(() {
                    myIndex = index;
                    products = products;
                  });
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: products,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.length,
                  itemBuilder: (item, index) => GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.only(top: 10.0, right: 15.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 12.0),
                      decoration: const BoxDecoration(
                        color: kBackgroundColor1,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            offset: Offset(1, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              /// Display image according to the product's category
                              Image(
                                image: AssetImage(
                                    getImage(snapshot.data[index].category)),
                                width: 50,
                                height: 50,
                              ),
                              const SizedBox(width: 23.0),
                              Column(
                                children: <Widget>[
                                  /// Display Product Name
                                  Text(
                                    snapshot.data[index].productName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: kTextColor3,
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),

                                  /// Display Quantity and Unit
                                  Text(
                                    '${snapshot.data[index].quantity.toString()} ${snapshot.data[index].unit}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: kTextColor4,
                                    ),
                                  )
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ],
                          ),

                          /// Edit button for each product
                          const Icon(
                            Icons.edit,
                            color: kButtonColor1,
                          ),
                        ],
                      ),
                    ),

                    /// Display Update Page when the row is pressed
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              UpdatePage(product: snapshot.data[index])),
                    ),
                  ),
                );
              } else {
                /// Loading Indicator
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }
}
