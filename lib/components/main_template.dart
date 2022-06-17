import 'package:flutter/material.dart';

import '../constants.dart';
import '../pages/product_list_page.dart';
import '../pages/shopping_list_page.dart';

class MainTemplate extends StatefulWidget {
  final int myIndex;

  const MainTemplate({Key? key, required this.myIndex}) : super(key: key);

  @override
  State<MainTemplate> createState() => _MainTemplateState();
}

class _MainTemplateState extends State<MainTemplate> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.myIndex;
  }

  static const List<Widget> _widgetOptions = <Widget>[
    ProductListPage(),
    ShoppingListPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        title: const Text(
          'FridgeY',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w900,
            color: kTextColor2,
            letterSpacing: 3,
          ),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'My Fridge',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Shopping List',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kButtonColor1,
        onTap: _onItemTapped,
      ),
    );
  }
}
