/*
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp();
  }
}
 */

import 'package:flutter/material.dart';
import 'package:fridgey/sqflite/database.dart';
import 'package:fridgey/sqflite/model.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatelessWidget(),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  test() async {
    const product = Product(
      productName: 'productName',
      category: 'category',
      quantity: 1,
      unit: 'unit',
    );
    print('=====createProduct=====');
    await FridgeyDb.instance.createProduct(product);
    print('=====readProducts=====');
    List<Product> returnedProducts = await FridgeyDb.instance.readProducts();
    print(returnedProducts.toString());

    print('=====updateProduct=====');
    const id = 5;
    const newProduct = Product(
      id: id,
      productName: 'productName2',
      category: 'category2',
      quantity: 2,
      unit: 'unit2',
    );
    await FridgeyDb.instance.updateProduct(newProduct);
    print('=====readProduct=====');
    Product returnedProduct2 = await FridgeyDb.instance.readProduct(id);
    print(returnedProduct2.toString());
    print('=====readProducts=====');
    List<Product> returnedProducts2 = await FridgeyDb.instance.readProducts();
    print(returnedProducts2.toString());

    print('=====deleteProduct=====');
    await FridgeyDb.instance.deleteProduct(1);
    print('=====readProducts=====');
    List<Product> returnedProducts3 = await FridgeyDb.instance.readProducts();
    print(returnedProducts3.toString());
    print('=====readProduct=====');
    Product returnedProduct3 = await FridgeyDb.instance.readProduct(1);
    print(returnedProduct3.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Floating Action Button'),
      ),
      body: const Center(child: Text('Press the button below!')),
      floatingActionButton: FloatingActionButton(
        onPressed: test,
        backgroundColor: Colors.green,
        child: const Icon(Icons.navigation),
      ),
    );
  }
}
