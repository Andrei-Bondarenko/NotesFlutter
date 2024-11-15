import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/domain/interactor/auth_interactor.dart';
import '../../../note/domain/interactor/note_interactor.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required AuthInteractor authInteractor,
    required NoteInteractor noteInteractor,
  })  : _authInteractor = authInteractor,
        _noteInteractor = noteInteractor,
        super(const ProfileState(isLoading: true)) {
    on<ProfileUserSubscribed>(_onProfileUserSubscribed);
    on<ProfileUserChanged>(_onProfileUserChanged);
    on<ProfileCurrentUserLoaded>(_onProfileCurrentUserLoaded);
    on<ProfileLogOutButtonClicked>(_onProfileLogOutButtonClicked);
  }

  final NoteInteractor _noteInteractor;
  final AuthInteractor _authInteractor;

  void _onProfileUserSubscribed(
    ProfileUserSubscribed event,
    Emitter<ProfileState> emit,
  ) {
    _authInteractor.observeRemoteUser().listen((user) {
      add(ProfileUserChanged(user: user));
    });
  }

  void _onProfileCurrentUserLoaded(
    ProfileCurrentUserLoaded event,
    Emitter<ProfileState> emit,
  ) {
    final user = _authInteractor.getUser();
    emit(state.copyWith(user: () => user, isLoading: false));
  }

  void _onProfileLogOutButtonClicked(
    ProfileLogOutButtonClicked event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await _noteInteractor.deleteAllLocalNotes();
    await _authInteractor.logOut();
    emit(state.copyWith(isLoading: false));
  }

  void _onProfileUserChanged(
    ProfileUserChanged event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith(user: () => event.user));
  }
}
