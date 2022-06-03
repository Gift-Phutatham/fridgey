import 'package:flutter/material.dart';

import '../constants.dart';
import '../pages/create_page.dart';

class MyFloatingActionButton extends StatefulWidget {
  const MyFloatingActionButton({Key? key}) : super(key: key);

  @override
  State<MyFloatingActionButton> createState() => _MyFloatingActionButtonState();
}

class _MyFloatingActionButtonState extends State<MyFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CreatePage()),
      ),
      backgroundColor: kButtonColor1,
      child: const Icon(Icons.add),
    );
  }
}
