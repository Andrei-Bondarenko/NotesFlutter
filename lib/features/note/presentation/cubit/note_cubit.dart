import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/features/note/domain/interactor/note_interactor.dart';
import 'package:notes/features/note/domain/models/note.dart';
import 'package:uuid/uuid.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit({
    String? id,
    required NoteInteractor noteInteractor,
  })  : _noteInteractor = noteInteractor,
        super(const NoteState(title: '', content: '')) {
    if (id != null) _loadNoteById(id);
  }

  final NoteInteractor _noteInteractor;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  void updateTitle(String title) {
    emit(state.copyWith(title: title));
  }

  void updateContent(String content) {
    emit(state.copyWith(content: content));
  }

  void saveNote() async {
    final id = state.id ?? const Uuid().v4();
    final note = Note(id: id, title: state.title, content: state.content);
    await _noteInteractor.saveNote(note);
    emit(state.copyWith(needExit: true));
  }

  void _loadNoteById(String id) async {
    emit(state.copyWith(id: id, isLoading: true));
    await Future.delayed(const Duration(milliseconds: 300));
    final note = await _noteInteractor.getNoteById(id);
    titleController.text = note?.title ?? '';
    contentController.text = note?.content ?? '';
    emit(state.copyWith(isLoading: false));
  }
}
