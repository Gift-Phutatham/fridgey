const String shoppingItemTable = 'shopping';

class ShoppingItemFields {
  static final List<String> values = [
    id,
    shoppingItemName,
    isChecked,
  ];

  static const String id = '_id';
  static const String shoppingItemName = 'shoppingItemName';
  static const String isChecked = 'isChecked';
}

class ShoppingItem {
  final int? id;
  final String shoppingItemName;
  final int isChecked;

  ShoppingItem({
    this.id,
    required this.shoppingItemName,
    required this.isChecked,
  });

  Map<String, Object?> toJson() => {
        ShoppingItemFields.id: id,
        ShoppingItemFields.shoppingItemName: shoppingItemName,
        ShoppingItemFields.isChecked: isChecked,
      };

  static ShoppingItem fromJson(Map<String, Object?> json) => ShoppingItem(
        id: json[ShoppingItemFields.id] as int?,
        shoppingItemName: json[ShoppingItemFields.shoppingItemName] as String,
        isChecked: json[ShoppingItemFields.isChecked] as int,
      );

  @override
  String toString() {
    return 'ShoppingList(Id: $id, Shopping Item: $shoppingItemName, Is Checked: $isChecked)';
  }
}
