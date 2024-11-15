import '../../../generated/l10n.dart';

enum ReminderType {
  event,
  task;

  const ReminderType();

  String getTitle() {
    return switch (this) {
      ReminderType.task => S.current.task,
      ReminderType.event => S.current.event,
    };
  }

  static ReminderType from(String type) {
    return switch (type) {
      'Task' => ReminderType.task,
      'Event' => ReminderType.event,
      _ => ReminderType.event
    };
  }
}
