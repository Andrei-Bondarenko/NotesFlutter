part of 'notes_list_bloc.dart';

class NotesListState extends Equatable {
  final List<Note> notes;
  final bool isLoading;

  const NotesListState({
    required this.isLoading,
    required this.notes,
  });

  NotesListState copyWith({
    List<Note>? notes,
    bool? isLoading,
  }) {
    return NotesListState(
      notes: notes ?? this.notes,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        notes,
        isLoading,
      ];
}
