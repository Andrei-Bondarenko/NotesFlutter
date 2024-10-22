import '../models/note.dart';

abstract class NoteRemoteRepository {
  Future saveNote(Note note, String userId);

  Future<List<Note>> getNotes(String userId);

  // Future<Note?> getNoteById(int id);

Future deleteNote(String userId, String noteId);
}
