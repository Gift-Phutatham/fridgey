const String table = 'fridgey';

class DbFields {
  static final List<String> values = [
    id,
    productName,
    category,
    quantity,
    unit
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

/// Mock data
List<String> categories = [
  "Starch & Grains",
  "Fruits & Vegetables",
  "Meat & Fish",
  "Dairy",
  "Others",
];

List<String> allCategories = [
  "All",
  "Starch & Grains",
  "Fruits & Vegetables",
  "Meat & Fish",
  "Dairy",
  "Others",
];

List<String> units = [
  "kilogram",
  "milligram",
  "unit",
];

/*
List<Product> products = [
  Product(
    id: 1,
    productName: "Rice",
    category: categories[0],
    quantity: 1,
    unit: units[0],
  ),
  Product(
    id: 2,
    productName: "Apple",
    category: categories[1],
    quantity: 2,
    unit: units[2],
  ),
  Product(
    id: 3,
    productName: "Chicken",
    category: categories[2],
    quantity: 3,
    unit: units[0],
  ),
  Product(
    id: 4,
    productName: "Cheese",
    category: categories[3],
    quantity: 40,
    unit: units[1],
  ),
  Product(
    id: 5,
    productName: "Beer",
    category: categories[4],
    quantity: 5,
    unit: units[2],
  ),
  Product(
    id: 6,
    productName: "Candy",
    category: categories[4],
    quantity: 6,
    unit: units[2],
  ),
];
 */
