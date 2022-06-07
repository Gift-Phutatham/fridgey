import 'package:flutter/material.dart';

import '../components/data_entry.dart';
import '../models/product.dart';

class UpdatePage extends StatefulWidget {
  final Product product;

  const UpdatePage({Key? key, required this.product}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  @override
  Widget build(BuildContext context) {
    return DataEntry(
      kind: 1,
      title: 'Edit Product',
      product: widget.product,
    );
  }
}
