import 'package:notes/features/notes_list/presentation/bloc/notes_list_bloc.dart';

import '../../../core/di/dependency_injection.dart';

void initNotesListModule() {
  getIt.registerLazySingleton (() => NotesListBloc(
        noteInteractor: getIt(),
        authInteractor: getIt(),
      ));
}
