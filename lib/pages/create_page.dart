import 'package:flutter/material.dart';

import '../components/data_entry.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  @override
  Widget build(BuildContext context) {
    return const DataEntry(
      kind: 0,
      title: 'Add Product',
    );
  }
}
