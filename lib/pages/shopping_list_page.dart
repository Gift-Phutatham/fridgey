import 'package:flutter/material.dart';

import '../components/main_template.dart';
import '../components/shopping_list.dart';
import '../constants.dart';
import '../database/shopping_item_model.dart';
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

      /// Add Button using FloatingActionButton
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 35),
        child: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: kButtonColor1,

          /// Display Add Dialog when the button is pressed
          onPressed: () => addDialog(context),
        ),
      ),
    );
  }

  Future<void> addDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        /// Add dialog using AlertDialog
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

              /// Display a warning text if there exists an empty field
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return kRequiredText;
                }
                return null;
              },
            ),
          ),
          actions: <Widget>[
            /// Cancel button
            getElevatedButton(
                false, 'Cancel', kButtonColor1, kBackgroundColor1),

            /// Add button
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
        minimumSize: const Size(75, 35),
      ),
      onPressed: () {
        /// Check whether or not the field is empty before adding the shopping item
        if (isAddButton) {
          if (_formKey.currentState!.validate()) {
            createShoppingItem();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MainTemplate(myIndex: 1)),
            );
          }
        } else {
          Navigator.of(context).pop();
        }
      },
    );
  }

  /// Add to the database
  Future createShoppingItem() async {
    final shoppingItem = ShoppingItem(
      shoppingItemName: _shoppingItemName.text,

      /// The CheckBox should not be checked when the item is just created.
      isChecked: 0,
    );
    await FridgeyDb.instance.createShoppingItem(shoppingItem);
  }
}
