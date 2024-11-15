import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/core/di/dependency_injection.dart';
import 'package:notes/core/navigation/routes/reminder_details_route.dart';
import 'package:notes/core/ui/widgets/calendar/calendar.dart';
import 'package:notes/features/reminder_details/domain/models/reminder_data.dart';
import 'package:notes/features/reminders/presentation/bloc/reminders_bloc.dart';

class RemindersPage extends StatelessWidget {
  const RemindersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      getIt<RemindersBloc>()
        ..add(RemindersDataLoaded()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reminders'),
        ),
        floatingActionButton: const _AddNewButton(),
        body: const _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemindersBloc, RemindersState>(
      builder: (context, state) {
        final selectedDay = state.selectedDay;
        final reminders = state.reminders
            .where((element) =>
        element.date.year == selectedDay.year &&
            element.date.month == selectedDay.month &&
            element.date.day == selectedDay.day)
            .toList();
        return ListView(
        children: [
        const _CalendarWidget(),
        const Divider(),
        for (int i = 0; i < reminders.length; i++)
        _ReminderTile(reminder: reminders[i], index: i),
        ],
        );
      },
    );
  }
}

class _CalendarWidget extends StatelessWidget {
  const _CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedDay = context.select((RemindersBloc bloc) => bloc.state.selectedDay);
    final bloc = context.read<RemindersBloc>();
    final reminders = context.select((RemindersBloc bloc) => bloc.state.reminders);
    return CalendarWidget(
      selectedDay: selectedDay,
      onDaySelected: (selectedDay, focusedDay) {
        bloc.add(RemindersDayTapped(selectedDay: selectedDay));
      },
      eventLoader: (day) {
        final list = reminders
            .where((element) =>
        element.date.year == day.year &&
            element.date.month == day.month &&
            element.date.day == day.day)
            .toList();
        return list.isNotEmpty ? [1] : [];
      },
    );
  }
}


class _AddNewButton extends StatelessWidget {
  const _AddNewButton({super.key});

  @override
  Widget build(BuildContext context) {
    final date = context.select((RemindersBloc bloc) => bloc.state.selectedDay);
    final bloc = context.read<RemindersBloc>();
    return FloatingActionButton(
      backgroundColor: Colors.orangeAccent,
      onPressed: () {
        final route = ReminderDetailsRoute.getRouteWithArgs(date: date);
        context.push(route).then((value) => bloc.add(RemindersDataLoaded()));
      },
      child: const Icon(Icons.add_alarm_outlined),
    );
  }
}

class _ReminderTile extends StatelessWidget {
  const _ReminderTile({super.key, required this.reminder, required this.index});

  final ReminderData reminder;
  final int index;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RemindersBloc>();
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black)
      ),
      margin: const EdgeInsets.all(8),
      child: ListTile(
        onTap: () {
          final route = ReminderDetailsRoute.getRouteWithArgs(date: reminder.date, id: reminder.id);
          context.push(route).then((value) => bloc.add(RemindersDataLoaded()));
        },
        title: Text(reminder.title, style: const TextStyle(fontSize: 18)),
        subtitle: Text(reminder.description),
        leading: Text(
          (index + 1).toString(),
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
