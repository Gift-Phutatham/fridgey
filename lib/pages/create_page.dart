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
        backgroundColor: kBackgroundColor,
        elevation: 0,
        title: const Center(
          child: Text(
            'CREATE',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: kDarkTextColor,
            ),
          ),
        ),
      ),
      body: const DataEntry(),
    );
  }
}
