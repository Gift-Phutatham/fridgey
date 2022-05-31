import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model.dart';

class FridgeyDb {
  static final FridgeyDb instance = FridgeyDb._init();

  static Database? _database;

  FridgeyDb._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb('fridgey.db');
    return _database!;
  }

  Future<Database> _initDb(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future _createDb(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';
    await db.execute('''
      CREATE TABLE $table ( 
        ${DbFields.id} $idType, 
        ${DbFields.productName} $textType,
        ${DbFields.category} $textType,
        ${DbFields.quantity} $intType,
        ${DbFields.unit} $textType,
      )
    ''');
  }

  Future<int> create(Product product) async {
    final db = await instance.database;
    return await db.insert(table, product.toJson());
  }

  Future<Product> readProduct(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      table,
      columns: DbFields.values,
      where: '${DbFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Product.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Product>> readProducts() async {
    final db = await instance.database;
    const orderBy = '${DbFields.productName} ASC';
    final result = await db.query(table, orderBy: orderBy);
    return result.map((json) => Product.fromJson(json)).toList();
  }

  Future<int> update(Product product) async {
    final db = await instance.database;
    return db.update(
      table,
      product.toJson(),
      where: '${DbFields.id} = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      table,
      where: '${DbFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
