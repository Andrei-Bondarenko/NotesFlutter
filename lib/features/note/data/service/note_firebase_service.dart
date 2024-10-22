import 'package:firebase_database/firebase_database.dart';
import 'package:notes/core/firebase/database/database_references.dart';

import '../db/models/note_entity.dart';

class NoteFirebaseService {
  final _ref = FirebaseDatabase.instance.ref(DatabaseReferences.notes);

  Future insertNote(String userId, NoteEntity entity) async {
    return _ref.child(userId).child(entity.id).set(entity.toFirebaseJson());
  }

  Future<List<NoteEntity>> getNotes(String userId) async {
    final dataSnapshot = await _ref.child(userId).get();
    final dynamic maps = dataSnapshot.children.map((e) {
      final key = e.key as String;
      final value = e.value as Map<String, dynamic>;
      return NoteEntity.fromFirebaseJson(key, value);
    }).toList();
    return maps;
  }

  Future deleteNote(String userId, String noteId) async  {
    _ref.child(userId).child(noteId).remove();
  }

}
