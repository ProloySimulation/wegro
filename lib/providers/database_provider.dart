import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider extends ChangeNotifier {
  late Database _database;
  bool _isDatabaseInitialized = false;

  Future<void> initializeDatabase() async {
    if (!_isDatabaseInitialized) {
      _database = await openDatabase(
        join(await getDatabasesPath(), 'product_database.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE products(id INTEGER PRIMARY KEY, title TEXT, image TEXT, price REAL, description TEXT, category TEXT, rating REAL)',
          );
        },
        version: 1,
      );
      _isDatabaseInitialized = true;
    }
    notifyListeners();
  }

  Future<bool> insertData(Map<String, dynamic> data) async {
    try {
      await initializeDatabase(); // Ensure database is initialized
      await _database.insert('products', data);
      notifyListeners();
      return true; // Return true if insertion succeeds
    } catch (e) {
      print('Error inserting data: $e');
      return false; // Return false if insertion fails
    }
  }

  Future<List<Map<String, dynamic>>> queryData() async {
    await initializeDatabase(); // Ensure database is initialized
    return await _database.query('products');
  }

  Future<void> removeData(int id) async {
    await initializeDatabase(); // Ensure database is initialized
    await _database.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
    notifyListeners();
  }
}