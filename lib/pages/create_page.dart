import 'package:flutter/material.dart';

import '../components/data_entry.dart';
import '../constants.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kBackgroundColor1,
        elevation: 0,
        title: const Text(
          'CREATE',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: kTextColor2,
          ),
        ),
      ),
      body: const DataEntry(),
    );
  }
}
