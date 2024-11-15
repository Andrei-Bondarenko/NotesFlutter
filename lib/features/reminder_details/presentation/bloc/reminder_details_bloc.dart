import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/features/reminder_details/domain/interactor/reminder_details_interactor.dart';
import 'package:notes/features/reminder_details/domain/models/reminder_data.dart';
import 'package:notes/features/reminder_details/model/reminder_type.dart';
import 'package:uuid/uuid.dart';

part 'reminder_details_event.dart';

part 'reminder_details_state.dart';

class ReminderDetailsBloc extends Bloc<ReminderDetailsEvent, ReminderDetailsState> {
  ReminderDetailsBloc({
    required ReminderDetailsInteractor reminderDetailsInteractor,
    DateTime? selectedDay,
  })  : _reminderDetailsInteractor = reminderDetailsInteractor,
        super(ReminderDetailsState(
          selectedDay: selectedDay ?? DateTime.now(),
          type: ReminderType.event,
        )) {
    on<ReminderDetailsDayTapped>(_onReminderDetailsDayTapped);
    on<ReminderDetailsTimeSelected>(_onReminderDetailsTimeSelected);
    on<ReminderDetailsTypeChanged>(_onReminderDetailsTypeChanged);
    on<ReminderDetailsIsAllDayChanged>(_onReminderDetailsIsAllDayChanged);
    on<ReminderDetailsSaveButtonClicked>(_onReminderDetailsSaveButtonClicked);
    on<ReminderDetailsTitleChanged>(_onReminderDetailsTitleChanged);
    on<ReminderDetailsByIdLoaded>(_onReminderDetailsByIdLoaded);
  }

  final ReminderDetailsInteractor _reminderDetailsInteractor;

  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  void _onReminderDetailsIsAllDayChanged(
    ReminderDetailsIsAllDayChanged event,
    Emitter<ReminderDetailsState> emit,
  ) {
    emit(state.copyWith(isAllDay: event.isAllDay));
  }

  void _onReminderDetailsTypeChanged(
    ReminderDetailsTypeChanged event,
    Emitter<ReminderDetailsState> emit,
  ) {
    emit(state.copyWith(type: event.type));
  }

  void _onReminderDetailsDayTapped(
    ReminderDetailsDayTapped event,
    Emitter<ReminderDetailsState> emit,
  ) {
    emit(state.copyWith(selectedDay: event.selectedDay));
  }

  void _onReminderDetailsTimeSelected(
    ReminderDetailsTimeSelected event,
    Emitter<ReminderDetailsState> emit,
  ) {
    final timeOfDay = event.timeOfDay;
    if (timeOfDay == null) return;
    final currentDay = state.selectedDay.copyWith(hour: timeOfDay.hour, minute: timeOfDay.minute);
    emit(state.copyWith(selectedDay: currentDay));
  }

  void _onReminderDetailsSaveButtonClicked(
    ReminderDetailsSaveButtonClicked event,
    Emitter<ReminderDetailsState> emit,
  ) async {
    final id = state.id ?? const Uuid().v4();
    final reminder = ReminderData(
      id: id,
      title: titleController.text,
      description: descriptionController.text,
      isAllDay: state.isAllDay,
      date: state.selectedDay,
      type: state.type,
    );
    await _reminderDetailsInteractor.saveReminder(reminder);
    emit(state.copyWith(needExit: true));
  }

  void _onReminderDetailsTitleChanged(
    ReminderDetailsTitleChanged event,
    Emitter<ReminderDetailsState> emit,
  ) {
    emit(state.copyWith(title: ''));
  }

  void _onReminderDetailsByIdLoaded(
    ReminderDetailsByIdLoaded event,
    Emitter<ReminderDetailsState> emit,
  ) async {
    final id = event.id;
    debugPrint('ID => $id');
    if (id == null) return;
    emit(state.copyWith(id: event.id, isLoading: true));
    await Future.delayed(const Duration(milliseconds: 300));
    final reminder = await _reminderDetailsInteractor.getReminderById(id);
    titleController.text = reminder?.title ?? '';
    descriptionController.text = reminder?.description ?? '';
    emit(state.copyWith(
      isLoading: false,
      selectedDay: reminder?.date,
      type: reminder?.type,
      isAllDay: reminder?.isAllDay,
    ));
  }
}
