const String table = 'product';
const String table2 = 'shopping';

class ProductFields {
  static final List<String> values = [
    id,
    productName,
    category,
    quantity,
    unit,
  ];

  static const String id = '_id';
  static const String productName = 'productName';
  static const String category = 'category';
  static const String quantity = 'quantity';
  static const String unit = 'unit';
}

class Product {
  final int? id;
  final String productName;
  final String category;
  final int quantity;
  final String unit;

  Product({
    this.id,
    required this.productName,
    required this.category,
    required this.quantity,
    required this.unit,
  });

  Map<String, Object?> toJson() => {
        ProductFields.id: id,
        ProductFields.productName: productName,
        ProductFields.category: category,
        ProductFields.quantity: quantity,
        ProductFields.unit: unit,
      };

  static Product fromJson(Map<String, Object?> json) => Product(
        id: json[ProductFields.id] as int?,
        productName: json[ProductFields.productName] as String,
        category: json[ProductFields.category] as String,
        quantity: json[ProductFields.quantity] as int,
        unit: json[ProductFields.unit] as String,
      );

  @override
  String toString() {
    return 'Product(Id: $id, Product name: $productName, Category: $category, Quantity: $quantity, Unit: $unit)';
  }
}

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

List<String> getCategories() {
  return [
    "Starch & Grains",
    "Fruits & Vegetables",
    "Meat & Fish",
    "Drink & Beverage",
    "Others",
  ];
}

List<String> getAllCategories() {
  List<String> allCategories = getCategories();
  allCategories.insert(0, "All");
  return allCategories;
}

List<String> getUnits() {
  return [
    "kilogram",
    "milligram",
    "gram",
    "unit",
  ];
}

String getImage(String product) {
  late String toReturn;
  List<String> category = getCategories();
  if (product == category[0]) {
    toReturn = 'assets/starch_grains.png';
  } else if (product == category[1]) {
    toReturn = 'assets/fruits_vegetables.png';
  } else if (product == category[2]) {
    toReturn = 'assets/meat_fish.png';
  } else if (product == category[3]) {
    toReturn = 'assets/drink_beverage.png';
  } else {
    toReturn = 'assets/others.png';
  }
  return toReturn;
}
