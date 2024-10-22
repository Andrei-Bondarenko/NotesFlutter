import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/core/di/dependency_injection.dart';
import 'package:notes/features/note/presentation/cubit/note_cubit.dart';

import '../../../../generated/l10n.dart';

class NotePage extends StatelessWidget {
  const NotePage({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NoteCubit>(param1: id),
      child: BlocListener<NoteCubit, NoteState>(
        listener: (context, state) {
          if (state.needExit) {
            context.pop(true);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(id != null ? S.of(context).note_edit : S.of(context).note_create),
            actions: const [
              _SaveIcon(),
            ],
          ),
          body: const _Body(),
        ),
      ),
    );
  }
}

class _SaveIcon extends StatelessWidget {
  const _SaveIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NoteCubit>();
    return IconButton(
      onPressed: cubit.saveNote,
      icon: const Icon(Icons.save),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _TitleField(),
        _ContentField(),
      ],
    );
  }
}

class _ContentField extends StatelessWidget {
  const _ContentField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NoteCubit>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: S.of(context).enter_text,
          fillColor: Colors.white,
          border: const OutlineInputBorder(borderSide: BorderSide.none),
        ),
        style: const TextStyle(fontSize: 20, color: Colors.black87),
        maxLines: null,
        onChanged: cubit.updateContent,
      ),
    );
  }
}

class _TitleField extends StatelessWidget {
  const _TitleField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NoteCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: S.of(context).title,
          fillColor: Colors.white,
          border: const OutlineInputBorder(borderSide: BorderSide.none),
        ),
        style: const TextStyle(fontSize: 40, color: Colors.black),
        maxLines: null,
        onChanged: cubit.updateTitle,
      ),
    );
  }
}
