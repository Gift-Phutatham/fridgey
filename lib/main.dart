import 'package:flutter/material.dart';

import './components/main_template.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,

      /// The Home Page is My Fridge Section.
      home: MainTemplate(myIndex: 0),
    );
  }
}
