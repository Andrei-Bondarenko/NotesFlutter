import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/utils/validation_utils.dart';
import 'package:notes/features/auth/domain/interactor/auth_interactor.dart';
import 'package:notes/features/auth/presentation/bloc/auth_bloc.dart';

import '../../../../generated/l10n.dart';

part 'registration_event.dart';

part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc({required AuthInteractor authInteractor})
      : _authInteractor = authInteractor,
        super(const RegistrationState(isLoading: false)) {
    on<RegistrationEmailChanged>(_onEmailChanged);
    on<RegistrationPasswordChanged>(_onPasswordChanged);
    on<RegistrationRegisterButtonClicked>(_onRegisterButtonClicked);
  }

  final AuthInteractor _authInteractor;

  void _onEmailChanged(
    RegistrationEmailChanged event,
    Emitter<RegistrationState> emit,
  ) {
    final errorText = ValidationUtils.isValidEmail(event.email) ? null : S.current.email_text_error;
    emit(state.copyWith(email: event.email, emailTextError: () => errorText));
  }

  void _onPasswordChanged(
    RegistrationPasswordChanged event,
    Emitter<RegistrationState> emit,
  ) {
    final errorText = ValidationUtils.isValidPassword(event.password) ? null : S.current.password_text_error;
    emit(state.copyWith(password: event.password, passwordTextError: () => errorText));
  }

  Future<void> _onRegisterButtonClicked(
    RegistrationRegisterButtonClicked event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final userCredential = await _authInteractor.registerUser(state.email, state.password);
    print('USER CREDENTIAL ==>>> $userCredential');
    if (userCredential != null) {
      emit(state.copyWith(isLoading: false, isSuccessfullyRegistered: true));
    }
  }
}
