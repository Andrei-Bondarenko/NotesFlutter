import 'package:notes/features/note/data/db/note_db_service.dart';
import 'package:notes/features/note/data/mappers/note_data_mapper.dart';
import 'package:notes/features/note/data/repository/note_local_repository_impl.dart';
import 'package:notes/features/note/data/repository/note_remote_repository_impl.dart';
import 'package:notes/features/note/data/service/note_firebase_service.dart';
import 'package:notes/features/note/domain/interactor/note_interactor.dart';
import 'package:notes/features/note/domain/repository/note_local_repository.dart';
import 'package:notes/features/note/domain/repository/note_remote_repository.dart';
import 'package:notes/features/note/presentation/cubit/note_cubit.dart';

import '../../../core/di/dependency_injection.dart';

void initNoteModule() {
  getIt.registerLazySingleton(() => NoteDbService(notesDatabase: getIt()));
  getIt.registerLazySingleton(() => NoteFirebaseService());
  getIt.registerFactory(() => NoteDataMapper());

  getIt.registerLazySingleton<NoteLocalRepository>(() => NoteLocalRepositoryImpl(
        noteDbService: getIt(),
        noteDataMapper: getIt(),
      ));

  getIt.registerLazySingleton<NoteRemoteRepository>(() => NoteRemoteRepositoryImpl(
        noteFirebaseService: getIt(),
        noteDataMapper: getIt(),
      ));

  getIt.registerFactory(() => NoteInteractor(
      noteLocalRepository: getIt(), noteRemoteRepository: getIt(), authLocalRepository: getIt()));

  getIt.registerFactoryParam((String? param1, param2) => NoteCubit(id: param1, noteInteractor: getIt()));
}
