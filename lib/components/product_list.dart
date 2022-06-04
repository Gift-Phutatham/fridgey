import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/product.dart';
import '../pages/update_page.dart';
import '../sqflite/database.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  int myIndex = 0;
  final allCategories = getAllCategories();

  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    refreshProducts();
  }

  void refreshProducts() async {
    setState(() {
      products = FridgeyDb.instance.readProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
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
                        color:
                            myIndex == index ? kTextColor1 : Colors.transparent,
                      ),
                    ],
                  ),
                ),
                onTap: () async {
                  if (allCategories[index] != 'All') {
                    products = FridgeyDb.instance
                        .getProductByCategory(allCategories[index]);
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
                      margin: const EdgeInsets.only(
                        top: 10.0,
                        right: 15.0,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                        vertical: 12.0,
                      ),
                      decoration: const BoxDecoration(
                        color: kBackgroundColor1,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                        boxShadow: [
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
                              Image(
                                image: AssetImage(
                                    getImage(snapshot.data[index].category)),
                                width: 50,
                                height: 50,
                              ),
                              const SizedBox(width: 23.0),
                              Column(
                                children: <Widget>[
                                  Text(
                                    snapshot.data[index].productName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      color: kTextColor3,
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
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
                          const Icon(
                            Icons.edit,
                            color: kButtonColor1,
                          ),
                        ],
                      ),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              UpdatePage(product: snapshot.data[index])),
                    ),
                  ),
                );
              } else if (!snapshot.hasData) {
                return const Text('No data');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }
}
