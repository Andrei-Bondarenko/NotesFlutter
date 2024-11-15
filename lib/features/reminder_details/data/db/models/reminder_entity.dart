import 'package:equatable/equatable.dart';
import 'package:notes/features/note/data/db/note_db_service.dart';
import 'package:notes/features/reminders/presentation/bloc/reminders_bloc.dart';

import '../../../model/reminder_type.dart';
import '../reminders_db_service.dart';

class ReminderEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isAllDay;
  final String date;
  final String type;

  const ReminderEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.isAllDay,
    required this.date,
    required this.type,
  });

  factory ReminderEntity.fromJson(Map<String, dynamic> json) {
    return ReminderEntity(
      id: json[RemindersDbService.columnId],
      title: json[RemindersDbService.columnTitle],
      description: json[RemindersDbService.columnDescription],
      isAllDay: json[RemindersDbService.columnIsAllDay] == 0 ? false : true,
      date: json[RemindersDbService.columnDate],
      type: json[RemindersDbService.columnType],
    );
  }

  // factory ReminderEntity.fromFirebaseJson(String id, Map<dynamic, dynamic> json) {
  //   return ReminderEntity(
  //     id: id,
  //     title: json[RemindersDbService.columnTitle],
  //     description: json[RemindersDbService.columnDescription],
  //     isAllDay: json[RemindersDbService.columnIsAllDay],
  //     date: json[RemindersDbService.columnDate],
  //     type: json[RemindersDbService.columnType],
  //   );
  // }

  Map<String, dynamic> toJson() => {
        RemindersDbService.columnId: id,
        RemindersDbService.columnTitle: title,
        RemindersDbService.columnDescription: description,
        RemindersDbService.columnIsAllDay: isAllDay ? 1 : 0,
        RemindersDbService.columnDate: date,
        RemindersDbService.columnType: type,
      };

  // Map<String, dynamic> toFirebaseJson() => {
  //       RemindersDbService.columnId: id,
  //       RemindersDbService.columnTitle: title,
  //       RemindersDbService.columnDescription: description,
  //       RemindersDbService.columnIsAllDay: isAllDay,
  //       RemindersDbService.columnDate: date,
  //       RemindersDbService.columnType: type,
  //     };

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        description,
        isAllDay,
        date,
        type,
      ];
}
