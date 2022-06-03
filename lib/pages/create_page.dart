import 'package:flutter/material.dart';
import 'package:fridgey/pages/home_page.dart';

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
