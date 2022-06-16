import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models.dart';

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
        await db.execute('''
          CREATE TABLE $table ( 
            ${DbFields.id} $idType, 
            ${DbFields.productName} $textType,
            ${DbFields.category} $textType,
            ${DbFields.quantity} $intType,
            ${DbFields.unit} $textType
          )
        ''');
        await db.execute('''
          CREATE TABLE $table2 ( 
            ${DbFields2.id} $idType, 
            ${DbFields2.shoppingItem} $textType
          )
        ''');
      },
    );
  }

  Future<int> createProduct(Product product) async {
    final db = await instance.database;
    return await db.insert(table, product.toJson());
  }

  Future<int> createShoppingList(ShoppingList shoppingList) async {
    final db = await instance.database;
    return await db.insert(table2, shoppingList.toJson());
  }

  Future<List<Product>> readProducts() async {
    final db = await instance.database;
    final result = await db.query(table, orderBy: DbFields.productName);
    return result.map((json) => Product.fromJson(json)).toList();
  }

  Future<List<Product>> readShoppingList() async {
    final db = await instance.database;
    final result = await db.query(table2, orderBy: DbFields2.shoppingItem);
    return result.map((json) => Product.fromJson(json)).toList();
  }

  Future<int> updateProduct(Product product) async {
    final db = await instance.database;
    return db.update(
      table,
      product.toJson(),
      where: '${DbFields.id} = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> deleteProduct(int? id) async {
    final db = await instance.database;
    return await db.delete(
      table,
      where: '${DbFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteShoppingList(int? id) async {
    final db = await instance.database;
    return await db.delete(
      table2,
      where: '${DbFields2.id} = ?',
      whereArgs: [id],
    );
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    final db = await instance.database;
    final result = await db.rawQuery(
      'SELECT * FROM $table WHERE category=? ORDER BY ${DbFields.productName}',
      [category],
    );
    return result.map((json) => Product.fromJson(json)).toList();
  }

  Future closeDb() async {
    final db = await instance.database;
    db.close();
  }
}
