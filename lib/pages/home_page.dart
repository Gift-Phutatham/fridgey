import 'package:flutter/material.dart';

import '../components/categories.dart';
import '../components/product_list.dart';
import '../constants.dart';
import '../pages/create_page.dart';

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
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 60,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CreatePage()),
        ),
        backgroundColor: kButtonColor1,
        child: const Icon(Icons.add),
      ),
    );
  }
}
