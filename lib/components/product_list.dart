import 'package:flutter/material.dart';
import 'package:fridgey/constants.dart';

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
    return FutureBuilder(
      future: products,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data.length,
            itemBuilder: (item, index) => GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(
                  top: 5.0,
                  bottom: 5.0,
                  right: 3.0,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
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
                        const SizedBox(width: 10.0),
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
                    const Image(
                      image: AssetImage('assets/update.png'),
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
        } else if (!snapshot.hasData) {
          return const Text('No data');
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
