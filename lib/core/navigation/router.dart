import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/core/navigation/routes/login_route.dart';
import 'package:notes/core/navigation/routes/note_route.dart';
import 'package:notes/core/navigation/routes/notes_list_route.dart';
import 'package:notes/core/navigation/routes/profile_route.dart';
import 'package:notes/core/navigation/routes/registration_route.dart';
import 'package:notes/core/navigation/routes/reminders_route.dart';
import 'package:notes/features/login/presentation/screen/login_page.dart';
import 'package:notes/features/note/presentation/screen/note_page.dart';
import 'package:notes/features/notes_list/presentation/screen/notes_list_page.dart';
import 'package:notes/features/profile/presentation/screen/profile_page.dart';
import 'package:notes/features/registration/presentation/screen/registration_page.dart';
import 'package:notes/features/reminders/presentation/screen/reminders_page.dart';
import 'package:path/path.dart';

import '../../features/home/presentation/screen/home_page.dart';

class NotesRouter {
  final GoRouter router = GoRouter(
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, child) => HomePage(navigationShell: child),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: [
              GoRoute(
                  path: NotesListRoute.name,
                  pageBuilder: (context, state) => const MaterialPage(child: NotesListPage()),
                  routes: [
                    GoRoute(
                        name: NoteRoute.name,
                        path: NoteRoute.name,
                        pageBuilder: (context, state) {
                          final id = state.uri.queryParameters[NoteRoute.idKeyArg];
                          return MaterialPage(child: NotePage(id: id));
                        }
                    ),
                  ]
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: ProfileRoute.name,
                pageBuilder: (context, state) =>
                const MaterialPage(
                  child: ProfilePage(),
                ),
                routes: [
                  GoRoute(
                    path: LoginRoute.name,
                    pageBuilder: (context, state) =>
                    const MaterialPage(
                      child: LoginPage(),
                    ),
                    routes: [
                      GoRoute(
                        path: RegistrationRoute.name,
                        pageBuilder: (context, state) =>
                        const MaterialPage(
                          child: RegistrationPage(),
                        ),
                      ),
                    ],
                  )
                ],),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RemindersRoute.name,
                pageBuilder: (context, state) => const MaterialPage(child: RemindersPage()),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
