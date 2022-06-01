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

  const Product({
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

  /// Mock data
  List<Product> products = [
    const Product(
      id: 1,
      productName: "productName1",
      category: "category1",
      quantity: 1,
      unit: "unit1",
    ),
    const Product(
      id: 2,
      productName: "productName2",
      category: "category2",
      quantity: 2,
      unit: "unit2",
    ),
    const Product(
      id: 3,
      productName: "productName3",
      category: "category3",
      quantity: 3,
      unit: "unit3",
    ),
    const Product(
      id: 4,
      productName: "productName4",
      category: "category4",
      quantity: 4,
      unit: "unit4",
    ),
    const Product(
      id: 5,
      productName: "productName5",
      category: "category5",
      quantity: 5,
      unit: "unit5",
    ),
    const Product(
      id: 6,
      productName: "productName6",
      category: "category6",
      quantity: 6,
      unit: "unit6",
    ),
  ];
}
