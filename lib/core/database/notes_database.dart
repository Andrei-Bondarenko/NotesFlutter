import 'package:flutter/cupertino.dart';
import 'package:notes/features/note/data/db/note_db_service.dart';
import 'package:notes/features/reminder_details/data/db/reminders_db_service.dart';
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

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: _databaseVersion,
    );
  }

  Future<void> _onCreate(Database db, int version) async {

    await db.execute('''
    CREATE TABLE ${NoteDbService.tableName}(
    ${NoteDbService.columnId} TEXT PRIMARY KEY, 
    ${NoteDbService.columnTitle} TEXT, 
    ${NoteDbService.columnContent} TEXT
    )
    ''');

    await db.execute('''
    CREATE TABLE ${RemindersDbService.tableName}(
    ${RemindersDbService.columnId} TEXT PRIMARY KEY, 
    ${RemindersDbService.columnTitle} TEXT, 
    ${RemindersDbService.columnDescription} TEXT,
    ${RemindersDbService.columnIsAllDay} INTEGER,
    ${RemindersDbService.columnDate} TEXT,
    ${RemindersDbService.columnType} TEXT
    )
    ''');
  }
}
