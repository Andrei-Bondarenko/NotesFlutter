part of 'notes_list_bloc.dart';

sealed class NotesListEvent extends Equatable{

  const NotesListEvent();

  @override
  List<Object?> get props => [];

}
class NotesDataLoaded extends NotesListEvent{}

class NoteDeleted extends NotesListEvent{
  final Note note;

  const NoteDeleted({required this.note});
}