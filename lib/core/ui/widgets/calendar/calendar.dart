import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({
    super.key,
    required this.selectedDay,
    required this.onDaySelected,
    required this.eventLoader
  });

  final DateTime selectedDay;
  final Function(DateTime selectedDay, DateTime focusedDay) onDaySelected;
  final List<int> Function(DateTime day)? eventLoader;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      eventLoader: eventLoader,
      focusedDay: selectedDay,
      currentDay: selectedDay,
      firstDay: DateTime(1900),
      lastDay: DateTime(2100),
      onDaySelected: onDaySelected,
    );
  }
}

class DateCalendarWidget extends StatelessWidget {
  const DateCalendarWidget({
    super.key,
    required this.selectedDay,
    required this.onDaySelected,
  });

  final DateTime selectedDay;
  final Function(DateTime selectedDay) onDaySelected;

  @override
  Widget build(BuildContext context) {
    return CalendarDatePicker(
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        onDateChanged: (selectedDay) => onDaySelected(selectedDay));
  }
}

class TimePicker extends StatelessWidget {
  const TimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return const TimePickerDialog(
        initialTime: TimeOfDay(
      hour: 0,
      minute: 0,
    ));
  }
}
