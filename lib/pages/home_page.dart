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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CreatePage()),
        ),
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
