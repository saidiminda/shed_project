// ignore_for_file: unused_field, avoid_print

import 'dart:io';

import 'package:hotel_booking/database/db_init_queries.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  final _dbName = "_admin_hotelBooking.db";

  DatabaseManager._privateConstructor();

  static final DatabaseManager instance = DatabaseManager._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Instantiate the database only when it's not been initialized yet.
    _database = await _initDatabase();
    return _database!;
  }

  Future<void> deleteDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    databaseFactory.deleteDatabase(path);
  }

  _initDatabase() async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, _dbName);
      return await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
      );
    } catch (e) {
      print(e);
    }
  } // Creates the database structure

  Future _onCreate(
    Database db,
    int version,
  ) async {
    print("Creating database....");
    await initQueries(db);

    print("Database created");
  }
}
