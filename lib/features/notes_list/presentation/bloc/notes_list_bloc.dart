import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/features/auth/domain/interactor/auth_interactor.dart';

import '../../../note/domain/interactor/note_interactor.dart';
import '../../../note/domain/models/note.dart';

part 'notes_list_event.dart';

part 'notes_list_state.dart';

class NotesListBloc extends Bloc<NotesListEvent, NotesListState> {
  NotesListBloc({
    required NoteInteractor noteInteractor,
    required AuthInteractor authInteractor,
  })  : _noteInteractor = noteInteractor,
        _authInteractor = authInteractor,
        super(const NotesListState(notes: [], isLoading: false)) {
    _observeUser();
    on<NotesDataLoaded>(_onNotesDataLoaded);
    on<NoteDeleted>(_onNoteDeleted);
  }

  final NoteInteractor _noteInteractor;
  final AuthInteractor _authInteractor;

  void _onNotesDataLoaded(
    NotesDataLoaded event,
    Emitter<NotesListState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final notes = await _noteInteractor.getNotes();
    emit(state.copyWith(notes: notes, isLoading: false));
  }

  void _onNoteDeleted(
      NoteDeleted event,
      Emitter<NotesListState> emit,
      ) async{
    final note = event.note;
    final notes = state.notes.toList();
    notes.remove(event.note);
    if(note.id != null) {
      _noteInteractor.deleteNote(note.id);
    }
    emit(state.copyWith(notes: notes));
  }

  void _observeUser() {
    _authInteractor.observeLocalUser().listen((user) {
      add(NotesDataLoaded());
    });
  }

}
