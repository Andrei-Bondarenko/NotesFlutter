import 'package:get_it/get_it.dart';
import 'package:notes/core/di/core_module.dart';
import 'package:notes/features/auth/di/auth_module.dart';
import 'package:notes/features/home/di/homeModule.dart';
import 'package:notes/features/login/di/login_module.dart';
import 'package:notes/features/note/di/note_module.dart';
import 'package:notes/features/notes_list/di/notes_list_module.dart';
import 'package:notes/features/profile/di/profileModule.dart';
import 'package:notes/features/registration/di/registration_module.dart';
import 'package:notes/features/reminder_details/di/reminder_details_module.dart';
import 'package:notes/features/reminders/di/reminders_module.dart';

final getIt = GetIt.instance;

void initDependencyInjection() {
  initCoreModule();
  initNoteModule();
  initNotesListModule();
  initAuthModule();
  initHomeModule();
  initLoginModule();
  initProfileModule();
  initRegistrationModule();
  initRemindersModule();
  initReminderDetailsModule() ;
}
