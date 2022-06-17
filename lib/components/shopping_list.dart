import 'package:flutter/material.dart';
import 'package:fridgey/components/main_template.dart';
import 'package:fridgey/database/models.dart';

import '../constants.dart';
import '../database/sqflite.dart';

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
      shoppingItems = FridgeyDb.instance.readShoppingList();
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
                      value: snapshot.data[index].isChecked == 1 ? true : false,
                      // secondary: SizedBox(
                      //   height: 50,
                      //   width: 50,
                      //   child: Image.asset(
                      //     checkBoxListTileModel[index].img,
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                      onChanged: (bool? value) {
                        setState(() {
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
    await FridgeyDb.instance.updateShoppingList(shoppingItem);
  }
}
