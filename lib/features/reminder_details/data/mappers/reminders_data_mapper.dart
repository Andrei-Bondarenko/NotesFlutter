import 'package:notes/features/reminder_details/data/db/models/reminder_entity.dart';
import 'package:notes/features/reminder_details/domain/models/reminder_data.dart';
import 'package:notes/features/reminder_details/model/reminder_type.dart';

class RemindersDataMapper {
  ReminderData map(ReminderEntity entity) {
    return ReminderData(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      isAllDay: entity.isAllDay,
      date: DateTime.parse(entity.date),
      type: ReminderType.from(entity.type),
    );
  }

  ReminderEntity mapToEntity(ReminderData data) {
    return ReminderEntity(
      id: data.id,
      title: data.title,
      description: data.description,
      isAllDay: data.isAllDay,
      date: data.date.toIso8601String(),
      type: data.type.name,
    );
  }
}
