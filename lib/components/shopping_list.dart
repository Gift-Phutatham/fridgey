import 'package:flutter/material.dart';

import '../components/main_template.dart';
import '../constants.dart';
import '../database/shopping_item_model.dart';
import '../database/sqflite.dart';

/// List all the shopping items
class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  late Future<List<ShoppingItem>> shoppingItems;

  @override
  void initState() {
    super.initState();
    setState(() {
      /// Get the list from database
      shoppingItems = FridgeyDb.instance.readShoppingItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: shoppingItems,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Container(
                    padding: const EdgeInsets.all(3.0),
                    child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        snapshot.data[index].shoppingItemName,
                        style:
                            const TextStyle(fontSize: 16, color: kTextColor3),
                      ),
                      activeColor: kButtonColor1,

                      /// Convert int to bool after getting data from the database
                      value: snapshot.data[index].isChecked == 1 ? true : false,
                      onChanged: (bool? value) {
                        setState(() {
                          /// Convert bool to int before updating the database
                          int isChecked = value! ? 1 : 0;
                          updateShoppingItem(snapshot.data[index], isChecked);
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  const MainTemplate(myIndex: 1),
                              transitionDuration: Duration.zero,
                            ),
                          );
                        });
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            /// Loading Indicator
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Future updateShoppingItem(ShoppingItem item, int isChecked) async {
    final shoppingItem = ShoppingItem(
      id: item.id,
      shoppingItemName: item.shoppingItemName,
      isChecked: isChecked,
    );

    /// Update the database
    await FridgeyDb.instance.updateShoppingItem(shoppingItem);
  }
}
