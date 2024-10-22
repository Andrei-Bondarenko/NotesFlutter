import 'package:equatable/equatable.dart';
import 'package:notes/features/note/data/db/note_db_service.dart';

class NoteEntity extends Equatable {
  final String id;
  final String title;
  final String content;

  const NoteEntity({
    required this.id,
    required this.title,
    required this.content,
  });

  factory NoteEntity.fromJson(Map<String, dynamic> json) {
    return NoteEntity(
      id: json[NoteDbService.columnId],
      title: json[NoteDbService.columnTitle],
      content: json[NoteDbService.columnContent],
    );
  }
  factory NoteEntity.fromFirebaseJson(String id, Map<dynamic, dynamic> json) {
    return NoteEntity(
      id: id,
      title: json[NoteDbService.columnTitle],
      content: json[NoteDbService.columnContent],
    );
  }

  Map<String, dynamic> toJson() => {
        NoteDbService.columnId: id,
        NoteDbService.columnTitle: title,
        NoteDbService.columnContent: content,
      };

  Map<String, dynamic> toFirebaseJson() => {
    NoteDbService.columnId: id,
    NoteDbService.columnTitle: title,
    NoteDbService.columnContent: content,
  };

  @override
  List<Object?> get props => [
        id,
        title,
        content,
      ];
}
