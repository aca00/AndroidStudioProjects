import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

class DatabaseHelper {
  static final _dbName = 'note.db';
  static final _dbVersion = 2;
  static final _tableName = 'noteTable2';
  static final columnId = '_id';
  static final title = 'title';
  static final description = 'description';
  static final date = 'date';
  static final starred = 'starred';

  //making a singleton class

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''

      CREATE TABLE $_tableName (

        $columnId INTEGER PRIMARY KEY,
        $title TEXT, 
        $description TEXT,
        $date TEXT,
        $starred INTEGER

         )   
           
      ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    debugPrint(' row  : ${row}');
    return await db.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM $_tableName');
    // return await db.query(_tableName);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];

    return db.update(_tableName, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(_tableName, where: '$columnId =?', whereArgs: [id]);
  }
}
