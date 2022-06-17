import 'package:flutter/material.dart';

import '../constants.dart';
import '../database/sqflite.dart';
import '../pages/product_list_page.dart';
import '../pages/shopping_list_page.dart';

/// MainTemplate of the application with Title, each page's Body, and BottomNavigationBar
/// @param myIndex - 0 for My Fridge, 1 for Shopping List
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

  /// Each page's body
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
        title: Text(
          _selectedIndex == 0 ? 'My Fridge' : 'Shopping List',
          style: const TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w900,
            color: kTextColor2,
          ),
        ),

        /// Clear All button for Shopping List
        actions: _selectedIndex == 1
            ? <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      FridgeyDb.instance.deleteShoppingItems();
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const MainTemplate(myIndex: 1),
                          transitionDuration: Duration.zero,
                        ),
                      );
                    },
                    child: const Text(
                      'Clear All',
                      style: TextStyle(
                        color: kButtonColor1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ]
            : [],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      /// BottomNavigationBar consists of My Fridge and Shopping List Sections
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
