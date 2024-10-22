import 'package:flutter/cupertino.dart';
import 'package:notes/features/note/data/db/note_db_service.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabase {
  static const String _databaseName = 'notes_database';
  static const int _databaseVersion = 1;

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath,_databaseName);

    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: _databaseVersion,
    );

  }

  Future<void> _onCreate(Database db, int version) async{
    debugPrint('\#\#\# onCreate');

    await db.execute('''
    CREATE TABLE ${NoteDbService.tableName}(
    ${NoteDbService.columnId} INTEGER PRIMARY KEY, 
    ${NoteDbService.columnTitle} TEXT, 
    ${NoteDbService.columnContent} TEXT
    )
    ''');

  }

}