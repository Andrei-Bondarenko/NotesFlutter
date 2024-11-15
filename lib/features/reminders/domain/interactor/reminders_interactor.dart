import '../../../reminder_details/domain/models/reminder_data.dart';
import '../../../reminder_details/domain/repository/reminders_local_repository.dart';

class RemindersInteractor {

  RemindersInteractor({
    required RemindersLocalRepository remindersLocalRepository,
    // required AuthLocalRepository authLocalRepository,
  }) : _remindersLocalRepository = remindersLocalRepository;

  final RemindersLocalRepository _remindersLocalRepository;


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

  Future<List<ReminderData>> getReminders() async {
    return _remindersLocalRepository.getReminders();
  }

}