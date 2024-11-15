import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/features/reminder_details/domain/models/reminder_data.dart';
import 'package:notes/features/reminders/domain/interactor/reminders_interactor.dart';

part 'reminders_event.dart';

part 'reminders_state.dart';

class RemindersBloc extends Bloc<RemindersEvent, RemindersState> {
  RemindersBloc({
    required RemindersInteractor remindersInteractor,
  })  : _remindersInteractor = remindersInteractor,
        super(RemindersState(selectedDay: DateTime.now())) {
    on<RemindersDayTapped>(_onRemindersDayTap);
    on<RemindersDataLoaded>(_onRemindersDataLoaded);
  }

  final RemindersInteractor _remindersInteractor;

  void _onRemindersDataLoaded(
    RemindersDataLoaded event,
    Emitter<RemindersState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final reminders = await _remindersInteractor.getReminders();
    emit(state.copyWith(reminders: reminders, isLoading: false));
  }

  void _onRemindersDayTap(RemindersDayTapped event, Emitter<RemindersState> emit) {
    emit(state.copyWith(selectedDay: event.selectedDay));
  }
}
