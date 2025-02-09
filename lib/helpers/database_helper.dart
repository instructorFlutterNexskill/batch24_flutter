import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DBHelper {
  static Database? _database;

  // Singleton pattern for the database
  static Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  // Initialize the database
  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE items(id INTEGER PRIMARY KEY, name TEXT)',
        );
      },
      version: 1,
    );
  }

  // Insert a new item
  static Future<void> insertItem(Map<String, dynamic> item) async {
    final db = await getDatabase();
    await db.insert(
      'items',
      item,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Retrieve all items
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await getDatabase();
    return await db.query('items');
  }

  // Update an item
  static Future<void> updateItem(Map<String, dynamic> item) async {
    final db = await getDatabase();
    await db.update(
      'items',
      item,
      where: 'id = ?',
      whereArgs: [item['id']],
    );
  }

  // Delete an item
  static Future<void> deleteItem(int id) async {
    final db = await getDatabase();
    await db.delete(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
