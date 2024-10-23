import 'dart:async';

import 'package:notes/core/models/event.dart';
import 'package:notes/features/auth/data/repository/auth_local_repository_impl.dart';
import 'package:notes/features/auth/domain/repository/auth_local_repository.dart';
import 'package:notes/features/note/domain/repository/note_local_repository.dart';
import 'package:notes/features/note/domain/repository/note_remote_repository.dart';

import '../models/note.dart';

class NoteInteractor {
  NoteInteractor({
    required NoteLocalRepository noteLocalRepository,
    required NoteRemoteRepository noteRemoteRepository,
    required AuthLocalRepository authLocalRepository,
  })  : _noteLocalRepository = noteLocalRepository,
        _noteRemoteRepository = noteRemoteRepository,
        _authLocalRepository = authLocalRepository;

  final NoteLocalRepository _noteLocalRepository;
  final NoteRemoteRepository _noteRemoteRepository;
  final AuthLocalRepository _authLocalRepository;

  final _controller = StreamController<bool>.broadcast();

  Stream<bool> get notesTriggerStream => _controller.stream;

  Future saveNote(Note note) async {
    final user = _authLocalRepository.getUser();
    final localData = _noteLocalRepository.saveNote(note);
    if (user == null) return localData;
    return _noteRemoteRepository.saveNote(note, user.uid);
  }

  Future<List<Note>> getNotes() async {
    final user = _authLocalRepository.getUser();
    if (user != null) {
      final notesList = await _noteRemoteRepository.getNotes(user.uid);
      await _noteLocalRepository.deleteAllLocalNotes();
      await _noteLocalRepository.saveNotesList(notesList);
     final musia = await _noteLocalRepository.getNotes();
     print('NOTES INTERACTOR LOCAL GET NOTES ==>> ${musia}');
    }
    return await _noteLocalRepository.getNotes();
  }

  Future<List<Note>> getLocalNotes() async {
    return _noteLocalRepository.getNotes();
  }

  Future<Note?> getNoteById(String id) => _noteLocalRepository.getNoteById(id);

  Future deleteNote(String id) async{
    await _noteLocalRepository.deleteNote(id);
    final user = _authLocalRepository.getUser();
    if(user != null) {
    return _noteRemoteRepository.deleteNote(user.uid, id);
    }
  }

  Future saveLocalNotesToRemote(List<Note> notes) async{
    final user = _authLocalRepository.getUser();
    if(user != null) {
      for (var note in notes) {
        await _noteRemoteRepository.saveNote(note, user.uid);
      }
    }
  }

  Future deleteAllLocalNotes() {
    return _noteLocalRepository.deleteAllLocalNotes();
  }
}
