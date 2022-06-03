import 'package:flutter/material.dart';

import '../components/data_entry.dart';
import '../constants.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kBackgroundColor1,
        elevation: 0,
        title: const Text(
          'EDIT',
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
