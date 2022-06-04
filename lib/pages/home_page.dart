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
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
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
        SizedBox(height: 3),
        Expanded(child: ProductList())
      ]),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 35),
        child: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: kButtonColor1,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreatePage()),
          ),
        ),
      ),
    );
  }
}
