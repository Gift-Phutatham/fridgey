import 'package:flutter/material.dart';

import '../components/categories.dart';
import '../components/product_list.dart';
import '../constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        title: const Text(
          'FRIDGEY',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: kDarkTextColor,
          ),
        ),
      ),
      body: Column(children: const <Widget>[
        Categories(),
        Expanded(child: ProductList())
      ]),
    );
  }
}
