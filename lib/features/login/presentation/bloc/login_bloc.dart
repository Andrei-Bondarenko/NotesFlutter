import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/di/dependency_injection.dart';
import 'package:notes/core/utils/validation_utils.dart';
import 'package:notes/features/auth/domain/interactor/auth_interactor.dart';
import 'package:notes/features/note/domain/interactor/note_interactor.dart';
import 'package:notes/features/notes_list/presentation/bloc/notes_list_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../../note/domain/models/note.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthInteractor authInteractor,
    required NoteInteractor noteInteractor,
  })  : _authInteractor = authInteractor,
        _noteInteractor = noteInteractor,
        super(const LoginState(isLoading: false, isSuccessfullySignedIn: false)) {
    on<LoginGoogleIconClicked>(_onLoginGoogleIconClicked);
    on<LoginAppleIconClicked>(_onLoginAppleIconClicked);
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSignInButtonClicked>(_onSignInButtonClicked);
    on<SaveLocalDataYesButtonClicked>(_onSaveLocalDataYesButtonClicked);
    on<SaveLocalDataNoButtonClicked>(_onSaveLocalDataNoButtonClicked);
  }

  final AuthInteractor _authInteractor;
  final NoteInteractor _noteInteractor;

  void _onSaveLocalDataYesButtonClicked(
    SaveLocalDataYesButtonClicked event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, isSuccessfullySignedIn: false));
    await _noteInteractor.saveLocalNotesToRemote(state.notesList);
    getIt<NotesListBloc>().add(NotesDataLoaded());
    emit(state.copyWith(isLoading: false, isSuccessfullySignedIn: true, isNotesListEmpty: true));
  }

  void _onSaveLocalDataNoButtonClicked(
      SaveLocalDataNoButtonClicked event,
      Emitter<LoginState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, isSuccessfullySignedIn: false));
    await _noteInteractor.deleteAllLocalNotes();
    final notes = await _noteInteractor.getLocalNotes();
    print('NOOOOOOOOOTEEEESSSSS ONNOCLICKED ==>> $notes');
    getIt<NotesListBloc>().add(NotesDataLoaded());
    emit(state.copyWith(isLoading: false, isSuccessfullySignedIn: true, isNotesListEmpty: true));
  }

  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    final errorText = ValidationUtils.isValidEmail(event.email) ? null : S.current.email_text_error;
    emit(state.copyWith(email: event.email, emailTextError: () => errorText));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final errorText =
        ValidationUtils.isValidPassword(event.password) ? null : S.current.password_text_error;
    emit(state.copyWith(password: event.password, passwordTextError: () => errorText));
  }

  void _onSignInButtonClicked(
    LoginSignInButtonClicked event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final notes = await _noteInteractor.getLocalNotes();
    final userCredential = await _authInteractor.signInWithEmailAndPassword(
      email: state.email,
      password: state.password,
    );
    if (userCredential != null) {
      emit(state.copyWith(
        isLoading: false,
        isSuccessfullySignedIn: true,
        isNotesListEmpty: notes.isEmpty,
        notesList: notes,
      ));
    }
    print('USER CREDENTIAL LOGIN==>>> $userCredential');
  }

  void _onLoginGoogleIconClicked(
    LoginGoogleIconClicked event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final credential = await _authInteractor.getGoogleCredential();
      final userCredential = await _authInteractor.signInWithCredential(credential);
      final notes = await _noteInteractor.getLocalNotes();
      emit(state.copyWith(isSuccessfullySignedIn: true, isNotesListEmpty: notes.isEmpty));
      debugPrint('USERCREDENTIAL: ${userCredential.user?.email}');
    } catch (e) {
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onLoginAppleIconClicked(
    LoginAppleIconClicked event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true));
      final credential = await _authInteractor.getAppleCredential();
      final userCredential = await _authInteractor.signInWithCredential(credential);
      emit(state.copyWith(isSuccessfullySignedIn: true));
      debugPrint('USERCREDENTIAL: ${userCredential.user?.email}');
    } catch (e) {
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
