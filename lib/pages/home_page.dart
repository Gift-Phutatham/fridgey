import 'package:flutter/material.dart';

import '../components/categories.dart';
import '../components/my_floating_action_button.dart';
import '../components/product_list.dart';
import '../constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: kBackgroundColor,
        elevation: 0,
        title: Transform(
          transform: Matrix4.translationValues(-50.0, 0.0, 0.0),
          child: const Text(
            'FRIDGEY',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: kDarkTextColor,
            ),
          ),
        ),
      ),
      body: Column(children: const <Widget>[
        Categories(),
        Expanded(child: ProductList())
      ]),
      floatingActionButton: const MyFloatingActionButton(),
    );
  }
}
