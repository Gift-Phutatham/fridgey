import 'package:flutter/material.dart';

import '../components/product_list.dart';
import '../constants.dart';
import '../pages/create_page.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const ProductList(),
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
