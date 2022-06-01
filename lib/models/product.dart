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
  "All",
  "Starch & Grains",
  "Fruits & Vegetables",
  "Meat & Fish",
  "Dairy",
  "Others",
];

List<Product> products = [
  Product(
    id: 1,
    productName: "Rice",
    category: categories[1],
    quantity: 1,
    unit: "unit1",
  ),
  Product(
    id: 2,
    productName: "",
    category: categories[2],
    quantity: 2,
    unit: "unit2",
  ),
  Product(
    id: 3,
    productName: "productName3",
    category: categories[3],
    quantity: 3,
    unit: "unit3",
  ),
  Product(
    id: 4,
    productName: "productName4",
    category: categories[4],
    quantity: 4,
    unit: "unit4",
  ),
  Product(
    id: 5,
    productName: "productName5",
    category: categories[5],
    quantity: 5,
    unit: "unit5",
  ),
  Product(
    id: 6,
    productName: "productName6",
    category: categories[5],
    quantity: 6,
    unit: "unit6",
  ),
];
