import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:notes/core/di/dependency_injection.dart';
import 'package:notes/features/reminder_details/model/reminder_type.dart';
import '../../../../generated/l10n.dart';
import '../bloc/reminder_details_bloc.dart';

class ReminderDetailsPage extends StatelessWidget {
  const ReminderDetailsPage({super.key, this.date, this.id});

  final DateTime? date;
  final String? id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<ReminderDetailsBloc>(param1: date)..add(ReminderDetailsByIdLoaded(id: id)),
      child: BlocListener<ReminderDetailsBloc, ReminderDetailsState>(
        listener: (context, state) {
          if (state.needExit) {
            context.pop();
           }
        },
        child: Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            title: const Text('Reminder Details'),
            actions: const [
              _SaveButton(),
            ],
          ),
          backgroundColor: Colors.white,
          body: _Body(date: date),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({super.key, this.date});

  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    final reminderType = context.select((ReminderDetailsBloc bloc) => bloc.state.type);
    final isLoading = context.select((ReminderDetailsBloc bloc) => bloc.state.isLoading);
    if(isLoading) return const Center( child: CircularProgressIndicator());
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        children: [
          const _TitleField(),
          _TagsRow(selectedType: reminderType),
          if (reminderType == ReminderType.event) const _EventBody() else const _TaskBody(),
        ],
      ),
    );
  }
}

class _TitleField extends StatelessWidget {
  const _TitleField({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ReminderDetailsBloc>();
    return TextField(
      controller: bloc.titleController,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: S.of(context).task_input_title,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
      style: const TextStyle(fontSize: 24),
    );
  }
}

class _TagsRow extends StatelessWidget {
  const _TagsRow({super.key, required this.selectedType});

  final ReminderType selectedType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          for (var type in ReminderType.values) ...[
            _TagWidget(type: type, isSelected: type == selectedType),
            const SizedBox(width: 8),
          ]
        ],
      ),
    );
  }
}

class _EventBody extends StatelessWidget {
  const _EventBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              _CurrentDate(),
              _CurrentTime(),
            ],
          ),
        )
      ],
    );
  }
}

class _TaskBody extends StatelessWidget {
  const _TaskBody({super.key});

  @override
  Widget build(BuildContext context) {
    final isAllDay = context.select((ReminderDetailsBloc bloc) => bloc.state.isAllDay);
    return SingleChildScrollView(
      child: Column(
        children: [
          const _AllDayWidget(),
          const _CurrentDate(),
          if (!isAllDay) const _CurrentTime(),
          const Divider(),
          const _DescriptionWidget(),
        ],
      ),
    );
  }
}

class _CurrentDate extends StatelessWidget {
  const _CurrentDate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ReminderDetailsBloc>();
    final date = context.select((ReminderDetailsBloc bloc) => bloc.state.selectedDay);
    final dateFormat = DateFormat.yMMMd('ru');
    final formattedDate = dateFormat.format(date);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Row(
        children: [
          const Text('Выбранная дата: '),
          const SizedBox(width: 20),
          TextButton(
            onPressed: () async {
              final selectedDay = await showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );
              bloc.add(ReminderDetailsDayTapped(selectedDay: selectedDay));
            },
            child: Text(formattedDate),
          ),
        ],
      ),
    );
  }
}

class _CurrentTime extends StatelessWidget {
  const _CurrentTime({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ReminderDetailsBloc>();
    final date = context.select((ReminderDetailsBloc bloc) => bloc.state.selectedDay);
    final dateFormat = DateFormat.Hm('ru');
    final formattedDate = dateFormat.format(date);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Row(
        children: [
          const Text('Выбранное время: '),
          const SizedBox(width: 20),
          TextButton(
            onPressed: () async {
              final timeOfDay = TimeOfDay.fromDateTime(date);
              final selectedTimeOfDay =
                  await showTimePicker(context: context, initialTime: timeOfDay);
              bloc.add(ReminderDetailsTimeSelected(timeOfDay: selectedTimeOfDay));
            },
            child: Text(formattedDate),
          ),
        ],
      ),
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.edit_note_outlined, size: 48),
          Expanded(
            child: TextField(
              scrollPadding: EdgeInsets.zero,
              controller: context.read<ReminderDetailsBloc>().descriptionController,
              maxLines: null,
              decoration: InputDecoration(
                hintText: S.of(context).enter_text,
                border: const OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TagWidget extends StatelessWidget {
  const _TagWidget({super.key, required this.type, required this.isSelected});

  final ReminderType type;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ReminderDetailsBloc>();
    return InkWell(
      onTap: () {
        bloc.add(ReminderDetailsTypeChanged(type: type));
      },
      splashColor: Colors.lightBlue.withOpacity(0.3),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Colors.lightBlue.withOpacity(0.3) : Colors.white,
        ),
        child: Text(
          type.getTitle(),
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
    );
  }
}

class _AllDayWidget extends StatelessWidget {
  const _AllDayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ReminderDetailsBloc>();
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.access_time_outlined),
              const SizedBox(width: 12),
              Text(
                S.of(context).task_all_day,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          BlocSelector<ReminderDetailsBloc, ReminderDetailsState, bool>(
            selector: (state) {
              return state.isAllDay;
            },
            builder: (context, value) {
              return Switch(
                value: value,
                onChanged: (value) => bloc.add(ReminderDetailsIsAllDayChanged(isAllDay: value)),
                activeColor: Colors.orangeAccent,
              );
            },
          )
        ],
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ReminderDetailsBloc>();
    // final title = context.select((ReminderDetailsBloc bloc) => bloc.state.title);
    return TextButton(
      onPressed: () {
              bloc.add(ReminderDetailsSaveButtonClicked());
            },
      child: const Icon(Icons.save),
    );
  }
}
