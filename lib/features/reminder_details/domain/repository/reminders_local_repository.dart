import 'package:notes/features/reminder_details/domain/models/reminder_data.dart';

abstract class RemindersLocalRepository {
  Future<int?> saveReminder(ReminderData reminder);

  Future saveRemindersList(List<ReminderData> remindersList);

  Future<List<ReminderData>> getReminders();

  Future<ReminderData?> getReminderById(String id);

  Future deleteReminder(String id);

  Future deleteAllLocalReminders();
}