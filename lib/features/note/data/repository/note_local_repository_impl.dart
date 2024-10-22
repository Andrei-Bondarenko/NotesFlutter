import 'package:flutter/cupertino.dart';
import 'package:notes/features/note/domain/repository/note_local_repository.dart';

import '../../domain/models/note.dart';
import '../db/models/note_entity.dart';
import '../db/note_db_service.dart';
import '../mappers/note_data_mapper.dart';

class NoteLocalRepositoryImpl implements NoteLocalRepository {
  final NoteDbService _noteDbService;
  final NoteDataMapper _noteDataMapper;

  const NoteLocalRepositoryImpl({
    required NoteDataMapper noteDataMapper,
    required NoteDbService noteDbService,
  })  : _noteDbService = noteDbService,
        _noteDataMapper = noteDataMapper;

  @override
  Future<int> saveNote(Note note) {
    NoteEntity entity = NoteEntity(id: note.id, title: note.title, content: note.content);
    final id = _noteDbService.insertNote(entity);
    debugPrint('### -> SAVE NOTE id: $id');
    return id;
  }

  @override
  Future<List<Note>> getNotes() {
    final entities = _noteDbService.getNotes();
    debugPrint('### -> GET NOTES entities: $entities');
    return entities.then((list) => list.map(_noteDataMapper.map).toList());
  }

  @override
  Future<Note?> getNoteById(String id) {
    final entity = _noteDbService.getNoteById(id);
    debugPrint('### -> GET NOTE BY ID id: $entity');
    return entity.then((e) => e == null ? null : _noteDataMapper.map(e));
  }

  @override
  Future deleteNote(String id) {
    return _noteDbService.deleteNote(id);
  }

  @override
  Future saveNotesList(List<Note> notesList) {
    final entities = notesList.map(_noteDataMapper.mapToEntity).toList();
    return _noteDbService.insertNotesList(entities);
  }

  @override
  Future deleteAllLocalNotes() {
    return _noteDbService.deleteAllNotes();
  }
}
