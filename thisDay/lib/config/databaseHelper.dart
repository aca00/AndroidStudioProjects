import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class DatabaseHelper {
  static final _dbName = 'superDatabase.db';
  static final _dbVersion = 2;
  static final _mainTable = 'mainTable';
  static final _storyTable = 'storyTable';
  static final _topicTable = 'topicTable';
  static final _monthTable = 'monthTable';
  static final _priorityTable = 'priorityTable';
  static final columnId = '_id';
  static final title = 'title';
  static final description = 'description';
  static final parentId = 'topic_id';
  static final priority = 'priority';
  static final iconId = 'iconId';
  static final futureImage = 'image';
  static final year = 'year';
  static final month = 'month';
  static final day = 'day';

  //making a singleton class

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database _database;

  // database set up

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else if (_database == null) {
      _database = await _checkPermission();

      return _database;
    }
  }

  var status;

  Future<Database> _checkPermission() async {
    this.status = await Permission.storage.status;
    debugPrint(' storage permission status  : ${this.status}');
    if (await Permission.storage.request().isGranted) {
      return await _initiateDatabase();
    } else if (await Permission.storage.request().isUndetermined) {
      debugPrint('Undetermined permission');
    } else if (await Permission.storage.request().isDenied) {
      debugPrint('Permission denied');
      _checkPermission();
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      debugPrint(' it has been permenantly denied');
    }
    return null;
  }

  Future<Database> _initiateDatabase() async {
    debugPrint(' database initialized');
    Directory directory = await getExternalStorageDirectory();

    String path = join(directory.path, _dbName);
    debugPrint('Path for database: ${path}');
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    debugPrint(' oncreate db');
    // main table
    await db.execute('''

      CREATE TABLE $_mainTable (

        $columnId INTEGER NOT NULL, 
        $year INTEGER,
        $month INTEGER,
        $day INTEGER,
        $title TEXT NOT NULL, 
        $description TEXT,  
        $priority INTEGER,
        $parentId INTEGER,
        PRIMARY KEY($columnId AUTOINCREMENT)
         );   
           
      '''); // parent for mainTable is story. That for story is topic
    await db.execute('''

      CREATE TABLE $_storyTable (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,
        $title TEXT, 
        $description TEXT,
        $parentId INTEGER, 
        $futureImage TEXT
         );   
           
      ''');
    await db.execute('''

      CREATE TABLE $_topicTable (

        $columnId INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE NOT NULL,
        $title TEXT, 
        $iconId INTEGER
         );  
           
      ''');
    await db.execute(''' 
    CREATE TABLE $_monthTable(
      $columnId INTEGER PRIMARY KEY,
      $title TEXT
    );
    
    ''');
    await db.execute(''' 
    CREATE TABLE $_priorityTable(
      $columnId INTEGER PRIMARY KEY,
      $title TEXT
    );
    
    ''');
    await db.rawInsert(''' 
    INSERT INTO $_priorityTable ($columnId, $title)
    VALUES
    (0,"Normal"),
    (1, "Green"),
    (2, "Blue"),
    (3, "Red")
    
    ''');
    await db.rawInsert(''' 
    INSERT INTO $_monthTable ($columnId, $title)
    VALUES 
    (1, "January"),
    (2, "February"),
    (3, "March"),
    (4, "April"),
    (5, "May"),
    (6, "June"),
    (7, "July"),
    (8, "August"),
    (9, "September"),
    (10, "October"),
    (11, "November"),
    (12, "December")
    
    ''');
  }

  // Database queries

  Future<List<Map<String, dynamic>>> queryForAllStories() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM $_storyTable');
  }

  //not yet used
  Future<List<Map<String, dynamic>>> queryForAllEvents() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM $_mainTable');
  }

  Future<List<Map<String, dynamic>>> universalQuery({dynamic query}) async {
    Database db = await instance.database;
    debugPrint('  query code at universalQuery : ${query}');
    return await db.rawQuery(query);
  }

  Future<List<Map<String, dynamic>>> queryForDatesOfMonth({String mnth}) async {
    Database db = await instance.database;
    return await db.rawQuery('''
      SELECT DISTINCT $day 
      FROM $_mainTable 
      WHERE $month IS $mnth 
      ORDER BY $day
      ''');
  }

  Future<List<Map<String, dynamic>>> queryForYearsOfStory({int storyId}) async {
    Database db = await instance.database;
    return db.rawQuery('''
      SELECT DISTINCT $year 
      FROM $_mainTable 
      WHERE $parentId IS $storyId 
      ORDER BY $year  
    ''');
  }

  Future<List<Map<String, dynamic>>> queryForDrafts() async {
    Database db = await instance.database;
    return await db.rawQuery('''
    SELECT m.$columnId, m.$year, m.$month, m.$day, m.$title, m.$description,
      m.$priority, m.$parentId, mn.$columnId AS monthNo, mn.$title AS monthName
      FROM $_mainTable m
      LEFT JOIN $_monthTable mn ON m.$month = mn.$columnId  
      WHERE m.$month IS null AND m.$day IS null AND m.$year IS null
    ORDER BY m.$year

    ''');
  }

  Future<List<Map<String, dynamic>>> queryForEventsAtDay(
      {dynamic mnth, dynamic dy}) async {
    Database db = await instance.database;
    return await db.rawQuery('''
      SELECT m.$columnId, m.$year, m.$month, m.$day, m.$title, m.$description,
      m.$priority, m.$parentId, mn.$columnId AS monthNo, mn.$title AS monthName
      FROM $_mainTable m
      LEFT JOIN $_monthTable mn ON m.$month = mn.$columnId  
      WHERE m.$month IS $mnth AND m.$day IS $dy
      ORDER BY m.$year
      ''');
  }

  Future<List<Map<String, dynamic>>> queryForEventsOfTheYearForStory({
    int storyId,
    int yr,
  }) async {
    Database db = await instance.database;
    return await db.rawQuery('''
    SELECT m.$columnId, m.$year, m.$month, m.$day, m.$title, m.$description, m.$priority, m.$parentId,
      mn.$title AS monthName
    FROM $_mainTable m
    LEFT JOIN $_monthTable mn ON m.$month = mn.$columnId
    WHERE m.$parentId IS $storyId   AND m.$year IS $yr
    ORDER BY m.$month, m.$day
    ''');
  }

  //  update operations

  Future<int> updateStory(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];

    return db.update(_storyTable, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> updateEvent(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];

    return db.update(_mainTable, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // insert operations

  Future<int> insertStory(Map<String, dynamic> row) async {
    Database db = await instance.database;
    debugPrint(' story  : ${row}');
    return await db.insert(_storyTable, row);
  }

  Future<int> insertEvent(Map<String, dynamic> row) async {
    Database db = await instance.database;
    debugPrint(' event  : ${row}');
    assert(db != null);
    return await db.insert(_mainTable, row);
  }

  // delete operations

  Future<int> deleteEvent(int id) async {
    Database db = await instance.database;
    return await db.delete(_mainTable, where: '$columnId =?', whereArgs: [id]);
  }

  Future<int> deleteEventsOfStory(int storyId) async {
    Database db = await instance.database;
    return await db
        .delete(_mainTable, where: '$parentId=?', whereArgs: [storyId]);
  }

  Future<int> deleteStory(int id) async {
    Database db = await instance.database;
    return await db.delete(_storyTable, where: '$columnId =?', whereArgs: [id]);
  }
}

// final List<Map<String, dynamic>> mapOfMonths = [
//     {"$columnId": 1, "$title": 'January'},
//     {"$columnId": 2, "$title": 'February'},
//     {"$columnId": 3, "$title": 'March'},
//     {"$columnId": 4, "$title": 'April'},
//     {"$columnId": 5, "$title": 'May'},
//     {"$columnId": 6, "$title": 'June'},
//     {"$columnId": 7, "$title": 'July'},
//     {"$columnId": 8, "$title": 'August'},
//     {"$columnId": 9, "$title": 'September'},
//     {"$columnId": 10, "$title": 'October'},
//     {"$columnId": 11, "$title": 'November'},
//     {"$columnId": 12, "$title": 'December'},
//   ];
