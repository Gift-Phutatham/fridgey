import 'package:flutter/material.dart';

import '../components/data_entry.dart';
import '../constants.dart';
import '../pages/home_page.dart';

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
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 60,
        leading: Container(
          margin: const EdgeInsets.only(left: 25),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: kButtonColor1,
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            ),
          ),
        ),
      ),
      body: const DataEntry(),
    );
  }
}
