import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/core/di/dependency_injection.dart';
import 'package:notes/core/navigation/routes/note_route.dart';
import 'package:notes/features/notes_list/presentation/bloc/notes_list_bloc.dart';

class NotesListPage extends StatelessWidget {
  const NotesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NotesListBloc>()..add(NotesDataLoaded()),
      child: const Scaffold(
        body: _Body(),
        floatingActionButton: _AddButton(),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final notesListBLoc = context.read<NotesListBloc>();
    return FloatingActionButton(
      backgroundColor: Colors.orangeAccent,
      child: const Icon(Icons.add),
      onPressed: () {
        context.push('/note').then((value) {
          if (value == true) {
            notesListBLoc.add(NotesDataLoaded());
          }
        });
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<NotesListBloc>();
    return BlocBuilder<NotesListBloc, NotesListState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: state.notes.length,
          itemBuilder: (BuildContext context, int index) {
            final note = state.notes[index];
            return ListTile(
              leading: const Icon(Icons.notes_outlined),
              key: ValueKey(note.id),
              title: Text(
                note.title,
                style: const TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                note.content,
              ),
              onTap: () {
                final id = note.id;
                context.push(NoteRoute.getRouteWithArgs(id)).then((value) {
                  if (value == true) {
                    bloc.add(NotesDataLoaded());
                   }
                });
              },
            );
          },
        );
      },
    );
  }
}
