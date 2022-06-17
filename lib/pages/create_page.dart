import 'package:flutter/material.dart';

import '../components/data_entry.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// CreatePage uses DataEntry Component
    return const DataEntry(
      isUpdatePage: 0,
      title: 'Add Product',
    );
  }
}
