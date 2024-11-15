import 'package:notes/core/di/dependency_injection.dart';
import 'package:notes/features/reminders/domain/interactor/reminders_interactor.dart';
import 'package:notes/features/reminders/presentation/bloc/reminders_bloc.dart';

void initRemindersModule() {
  getIt.registerFactory(() => RemindersInteractor(remindersLocalRepository: getIt()));
  getIt.registerFactory(() => RemindersBloc(remindersInteractor: getIt()));
}