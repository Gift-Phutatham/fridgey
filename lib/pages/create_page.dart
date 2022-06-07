import 'package:flutter/material.dart';

import '../components/data_entry.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DataEntry(
      kind: 0,
      title: 'Add Product',
    );
  }
}
