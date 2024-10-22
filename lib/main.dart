import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:notes/core/navigation/router.dart';

import 'core/di/dependency_injection.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initDependencyInjection();
  runApp(NotesApp(notesRouter: getIt()));
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key, required this.notesRouter});

  final NotesRouter notesRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: notesRouter.router.routeInformationProvider,
      routeInformationParser: notesRouter.router.routeInformationParser,
      routerDelegate: notesRouter.router.routerDelegate,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
