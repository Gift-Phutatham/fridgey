import 'package:flutter/material.dart';
import 'package:fridgey/database/models.dart';

import '../components/shopping_list.dart';
import '../constants.dart';
import '../database/sqflite.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({Key? key}) : super(key: key);

  @override
  State<ShoppingListPage> createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _shoppingItemName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const ShoppingList(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 35),
        child: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: kButtonColor1,
          onPressed: () => addDialog(context),
        ),
      ),
    );
  }

  Future<void> addDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Shopping Item'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _shoppingItemName,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                hintText: 'Enter Your Item',
                hintStyle: const TextStyle(fontSize: 14),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return kRequiredText;
                }
                return null;
              },
            ),
          ),
          actions: <Widget>[
            getElevatedButton(
                false, 'Cancel', kButtonColor1, kBackgroundColor1),
            getElevatedButton(true, 'Add', kBackgroundColor1, kButtonColor1),
          ],
        );
      },
    );
  }

  Widget getElevatedButton(isAddButton, text, textColor, backgroundColor) {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: backgroundColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        minimumSize: const Size(100, 40),
      ),
      onPressed: () {
        if (isAddButton) {
          if (_formKey.currentState!.validate()) {
            addShoppingItem();
            Navigator.of(context).pop();
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (_) => const ShoppingListPage()),
            // );
          }
        } else {
          Navigator.of(context).pop();
        }
      },
    );
  }

  Future addShoppingItem() async {
    final shoppingItem = ShoppingItem(
      shoppingItemName: _shoppingItemName.text,
      isChecked: 0,
    );
    await FridgeyDb.instance.createShoppingList(shoppingItem);
  }
}
