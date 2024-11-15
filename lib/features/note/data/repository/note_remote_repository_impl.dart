import 'package:flutter/cupertino.dart';
import 'package:notes/features/note/data/mappers/note_data_mapper.dart';
import 'package:notes/features/note/data/service/note_firebase_service.dart';
import 'package:notes/features/note/domain/repository/note_local_repository.dart';

import '../../domain/models/note.dart';
import '../../domain/repository/note_remote_repository.dart';
import '../db/models/note_entity.dart';
import '../db/note_db_service.dart';

class NoteRemoteRepositoryImpl implements NoteRemoteRepository {
  final NoteFirebaseService _noteFirebaseService;
  final NoteDataMapper _noteDataMapper;

  const NoteRemoteRepositoryImpl({
    required NoteDataMapper noteDataMapper,
    required NoteFirebaseService noteFirebaseService,
  })  : _noteFirebaseService = noteFirebaseService,
        _noteDataMapper = noteDataMapper;

  @override
  Future saveNote(Note note, String userId) {
    NoteEntity entity = _noteDataMapper.mapToEntity(note);
    return _noteFirebaseService.insertNote(userId, entity);
  }

  @override
  Future<List<Note>> getNotes(String userId) async {
    return await _noteFirebaseService
        .getNotes(userId)
        .then((list) => list.map(_noteDataMapper.map).toList());
  }

  @override
  Future deleteNote(String userId, String noteId) {
    return _noteFirebaseService.deleteNote(userId, noteId);
  }
}
