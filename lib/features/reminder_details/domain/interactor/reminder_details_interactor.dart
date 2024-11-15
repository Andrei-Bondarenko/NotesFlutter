import 'dart:async';

import 'package:notes/features/reminder_details/domain/models/reminder_data.dart';

import '../repository/reminders_local_repository.dart';

class ReminderDetailsInteractor {
  ReminderDetailsInteractor({
    required RemindersLocalRepository remindersLocalRepository,
    // required AuthLocalRepository authLocalRepository,
  }) : _remindersLocalRepository = remindersLocalRepository;

  // _authLocalRepository = authLocalRepository;

  final RemindersLocalRepository _remindersLocalRepository;

  // final AuthLocalRepository _authLocalRepository;

  final _controller = StreamController<bool>.broadcast();

  Stream<bool> get notesTriggerStream => _controller.stream;

  Future saveReminder(ReminderData note) async {
    // final user = _authLocalRepository.getUser();
    _remindersLocalRepository.saveReminder(note);
    // if (user == null) return localData;
    // return _noteRemoteRepository.saveNote(note, user.uid);
  }

  // Future<List<ReminderData>> getReminders() async {
  //   final user = _authLocalRepository.getUser();
  //   if (user != null) {
  //     final notesList = await _noteRemoteRepository.getNotes(user.uid);
  //     await _noteLocalRepository.deleteAllLocalNotes();
  //     await _noteLocalRepository.saveNotesList(notesList);
  //     final musia = await _noteLocalRepository.getNotes();
  //     print('NOTES INTERACTOR LOCAL GET NOTES ==>> ${musia}');
  //   }
  //   return await _remindersLocalRepository.getReminders();
  // }

  Future<List<ReminderData>> getLocalReminders() async {
    return _remindersLocalRepository.getReminders();
  }

  Future<ReminderData?> getReminderById(String id) {
    return _remindersLocalRepository.getReminderById(id);
  }

  Future deleteNote(String id) async {
    await _remindersLocalRepository.deleteReminder(id);
    // final user = _authLocalRepository.getUser();
    // if(user != null) {
    //   return _noteRemoteRepository.deleteNote(user.uid, id);
    // }
  }

  // Future saveLocalNotesToRemote(List<ReminderData> notes) async{
  //   final user = _authLocalRepository.getUser();
  //   if(user != null) {
  //     for (var note in notes) {
  //       await _noteRemoteRepository.saveNote(note, user.uid);
  //     }
  //   }
  // }

  Future deleteAllLocalNotes() {
    return _remindersLocalRepository.deleteAllLocalReminders();
  }
}
