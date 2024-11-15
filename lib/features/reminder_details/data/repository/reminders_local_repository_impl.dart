import 'package:flutter/cupertino.dart';
import 'package:notes/features/reminder_details/data/db/models/reminder_entity.dart';
import 'package:notes/features/reminder_details/data/db/reminders_db_service.dart';
import 'package:notes/features/reminder_details/data/mappers/reminders_data_mapper.dart';
import 'package:notes/features/reminder_details/domain/models/reminder_data.dart';
import 'package:notes/features/reminder_details/domain/repository/reminders_local_repository.dart';

class RemindersLocalRepositoryImpl implements RemindersLocalRepository {
  final RemindersDbService _remindersDbService;
  final RemindersDataMapper _remindersDataMapper;

  const RemindersLocalRepositoryImpl({
    required RemindersDbService remindersDbService,
    required RemindersDataMapper remindersDataMapper,
  })  : _remindersDbService = remindersDbService,
  _remindersDataMapper = remindersDataMapper;

  @override
  Future<int?> saveReminder(ReminderData data) {
    ReminderEntity entity = _remindersDataMapper.mapToEntity(data);
    final id = _remindersDbService.insertReminder(entity);
    return id;
  }

  @override
  Future<List<ReminderData>> getReminders() {
    final entities = _remindersDbService.getReminders();
    return entities.then((list) => list.map(_remindersDataMapper.map).toList());
  }

  @override
  Future<ReminderData?> getReminderById(String id) {
    final entity = _remindersDbService.getReminderById(id);
    return entity.then((e) => e == null ? null : _remindersDataMapper.map(e));
  }

  @override
  Future deleteReminder(String id) {
    return _remindersDbService.deleteReminder(id);
  }

  @override
  Future deleteAllLocalReminders() {
    return _remindersDbService.deleteAllReminders();
  }

  @override
  Future saveRemindersList(List<ReminderData> remindersList) {
    final entities = remindersList.map(_remindersDataMapper.mapToEntity).toList();
    return _remindersDbService.insertRemindersList(entities);
  }
}
