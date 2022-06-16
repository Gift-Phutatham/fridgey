const String table = 'fridgey';
const String table2 = 'fridgey2';

class DbFields {
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

class DbFields2 {
  static final List<String> values = [
    id,
    shoppingItem,
  ];

  static const String id = '_id';
  static const String shoppingItem = 'shoppingItem';
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
        DbFields.id: id,
        DbFields.productName: productName,
        DbFields.category: category,
        DbFields.quantity: quantity,
        DbFields.unit: unit,
      };

  static Product fromJson(Map<String, Object?> json) => Product(
        id: json[DbFields.id] as int?,
        productName: json[DbFields.productName] as String,
        category: json[DbFields.category] as String,
        quantity: json[DbFields.quantity] as int,
        unit: json[DbFields.unit] as String,
      );

  @override
  String toString() {
    return 'Product(Id: $id, Product name: $productName, Category: $category, Quantity: $quantity, Unit: $unit)';
  }
}

class ShoppingList {
  final int? id;
  final String shoppingItem;

  ShoppingList({
    this.id,
    required this.shoppingItem,
  });

  Map<String, Object?> toJson() => {
        DbFields2.id: id,
        DbFields2.shoppingItem: shoppingItem,
      };

  static ShoppingList fromJson(Map<String, Object?> json) => ShoppingList(
        id: json[DbFields2.id] as int?,
        shoppingItem: json[DbFields2.shoppingItem] as String,
      );

  @override
  String toString() {
    return 'ShoppingList(Id: $id, Shopping Item: $shoppingItem)';
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
