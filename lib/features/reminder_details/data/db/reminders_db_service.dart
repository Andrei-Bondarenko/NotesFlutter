import 'package:flutter/cupertino.dart';
import 'package:notes/core/database/notes_database.dart';
import 'package:notes/features/note/data/db/models/note_entity.dart';
import 'package:notes/features/reminder_details/data/db/models/reminder_entity.dart';
import 'package:sqflite/sqflite.dart';

class RemindersDbService {
  static const tableName = 'reminders';
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnDescription = 'description';
  static const columnIsAllDay = 'is_all_day';
  static const columnDate = 'date';
  static const columnType = 'type';


  final NotesDatabase _notesDatabase;

  RemindersDbService({required NotesDatabase notesDatabase}) : _notesDatabase = notesDatabase;

  Future<int> insertReminder(ReminderEntity entity) async {
    final database = await _notesDatabase.database;
    return database.insert(tableName, entity.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future insertRemindersList(List<ReminderEntity> notesList) async {
    final Database database = await _notesDatabase.database;
    final Batch batch = database.batch();

    for (ReminderEntity note in notesList) {
      batch.insert(tableName, note.toJson());
    }
    final List<dynamic> results = await batch.commit();

    debugPrint('REMINDERS DB RESULTS ===>>> $results');
  }

  Future<List<ReminderEntity>> getReminders() async {
    final db = await _notesDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    final check = maps.map((e) {
     return ReminderEntity.fromJson(e);
    }
    ).toList();
    return check;
  }

  Future<ReminderEntity?> getReminderById(String id) async {
    final db = await _notesDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? ReminderEntity.fromJson(maps[0]) : null;
  }

  Future deleteReminder(String id) async {
    final db = await _notesDatabase.database;
    return db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future deleteAllReminders() async {
    final db = await _notesDatabase.database;
    return db.delete(tableName);
  }
}
