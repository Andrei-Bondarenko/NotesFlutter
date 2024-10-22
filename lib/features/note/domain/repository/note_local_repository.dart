import '../models/note.dart';

abstract class NoteLocalRepository {
  Future<int?> saveNote(Note note);

  Future saveNotesList(List<Note> notesList);

  Future<List<Note>> getNotes();

  Future<Note?> getNoteById(String id);

  Future deleteNote(String id);

  Future deleteAllLocalNotes();
}
