import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/features/home/presentation/bloc/home_cubit.dart';
import 'package:notes/features/home/presentation/bloc/home_state.dart';

import '../../../../generated/l10n.dart';

class NotesBottomNavigationBar extends StatelessWidget {
  const NotesBottomNavigationBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: state.index,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.orangeAccent ,
        onTap: (index) {
          context.read<HomeCubit>().changeBottomNavBar(index);
          navigationShell.goBranch(index);
        },
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.checklist),
              label: S.of(context).notesList),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: S.of(context).profile,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.list_alt),
            label: S.of(context).reminders,
          ),
        ],
      );
    });
  }
}
