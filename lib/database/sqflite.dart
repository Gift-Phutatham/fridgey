import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'product_model.dart';
import 'shopping_item_model.dart';

class FridgeyDb {
  FridgeyDb._init();

  static final FridgeyDb instance = FridgeyDb._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb('fridgey.db');
    return _database!;
  }

  Future<Database> _initDb(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
        const textType = 'TEXT NOT NULL';
        const intType = 'INTEGER NOT NULL';
        const intTypeWithDefault = 'INTEGER NOT NULL DEFAULT 0';

        /// Table for My Fridge Section
        await db.execute('''
          CREATE TABLE $productTable ( 
            ${ProductFields.id} $idType, 
            ${ProductFields.productName} $textType,
            ${ProductFields.category} $textType,
            ${ProductFields.quantity} $intType,
            ${ProductFields.unit} $textType
          )
        ''');

        /// Table for Shopping List Section
        await db.execute('''
          CREATE TABLE $shoppingItemTable ( 
            ${ShoppingItemFields.id} $idType, 
            ${ShoppingItemFields.shoppingItemName} $textType,
            ${ShoppingItemFields.isChecked} $intTypeWithDefault
          )
        ''');
      },
    );
  }

  Future<int> createProduct(Product product) async {
    final db = await instance.database;
    return await db.insert(productTable, product.toJson());
  }

  Future<int> createShoppingItem(ShoppingItem shoppingList) async {
    final db = await instance.database;
    return await db.insert(shoppingItemTable, shoppingList.toJson());
  }

  Future<List<Product>> readProducts() async {
    final db = await instance.database;
    final result =
        await db.query(productTable, orderBy: ProductFields.productName);
    return result.map((json) => Product.fromJson(json)).toList();
  }

  Future<List<ShoppingItem>> readShoppingItems() async {
    final db = await instance.database;
    final result = await db.query(shoppingItemTable,
        orderBy: ShoppingItemFields.shoppingItemName);
    return result.map((json) => ShoppingItem.fromJson(json)).toList();
  }

  Future<int> updateProduct(Product product) async {
    final db = await instance.database;
    return db.update(
      productTable,
      product.toJson(),
      where: '${ProductFields.id} = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> updateShoppingItem(ShoppingItem shoppingItem) async {
    final db = await instance.database;
    return db.update(
      shoppingItemTable,
      shoppingItem.toJson(),
      where: '${ShoppingItemFields.id} = ?',
      whereArgs: [shoppingItem.id],
    );
  }

  Future<int> deleteProduct(int? id) async {
    final db = await instance.database;
    return await db.delete(
      productTable,
      where: '${ProductFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteShoppingItems() async {
    final db = await instance.database;
    return await db.delete(shoppingItemTable);
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    final db = await instance.database;
    final result = await db.rawQuery(
      'SELECT * FROM $productTable WHERE category=? ORDER BY ${ProductFields.productName}',
      [category],
    );
    return result.map((json) => Product.fromJson(json)).toList();
  }

  Future closeDb() async {
    final db = await instance.database;
    db.close();
  }
}
