import 'package:notes/features/note/data/db/models/note_entity.dart';
import 'package:notes/features/note/domain/models/note.dart';

class NoteDataMapper {
  Note map(NoteEntity entity) {
    return Note(
      id: entity.id,
      title: entity.title,
      content: entity.content,
    );
  }

  NoteEntity mapToEntity(Note note) {
    return NoteEntity(
      id: note.id,
      title: note.title,
      content: note.content,
    );
  }
}
