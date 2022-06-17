import 'package:flutter/material.dart';

import '../components/data_entry.dart';
import '../database/product_model.dart';

class UpdatePage extends StatelessWidget {
  final Product product;

  const UpdatePage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataEntry(
      isUpdatePage: 1,
      title: 'Edit Product',
      product: product,
    );
  }
}
