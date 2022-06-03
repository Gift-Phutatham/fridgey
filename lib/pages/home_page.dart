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
        backgroundColor: kBackgroundColor1,
        elevation: 0,
        toolbarHeight: 75,
        title: const Text(
          'FridgeY',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w900,
            color: kTextColor2,
            letterSpacing: 3,
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
