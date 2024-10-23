import 'package:flutter/cupertino.dart';
import 'package:notes/core/database/notes_database.dart';
import 'package:notes/features/note/data/db/models/note_entity.dart';
import 'package:sqflite/sqflite.dart';

class NoteDbService {
  static const tableName = 'notes';
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnContent = 'content';

  final NotesDatabase _notesDatabase;

  NoteDbService({required NotesDatabase notesDatabase}) : _notesDatabase = notesDatabase;

  Future<int> insertNote(NoteEntity entity) async {
    final database = await _notesDatabase.database;
    return database.insert(tableName, entity.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future insertNotesList(List<NoteEntity> notesList) async {
    final Database database = await _notesDatabase.database;
    final Batch batch = database.batch();

    for (NoteEntity note in notesList) {
      batch.insert(tableName, note.toJson());
    }
    final List<dynamic> results = await batch.commit();

    debugPrint('NOTE DB RESULTS ===>>> $results');
  }

  Future<List<NoteEntity>> getNotes() async {
    final db = await _notesDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    final check = maps.map((e) {
      print('RUNTIME TYPE ==>>> ${e}');
     return NoteEntity.fromJson(e);
    }
    ).toList();
    debugPrint('NOTE DB SERVICE DATA ==>> $check');
    return check;
  }

  Future<NoteEntity?> getNoteById(String id) async {
    final db = await _notesDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? NoteEntity.fromJson(maps[0]) : null;
  }

  Future deleteNote(String id) async {
    final db = await _notesDatabase.database;
    return db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future deleteAllNotes() async {
    final db = await _notesDatabase.database;
    return db.delete(tableName);
  }
}
