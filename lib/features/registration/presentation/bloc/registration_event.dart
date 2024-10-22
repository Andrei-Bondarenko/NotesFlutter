part of 'registration_bloc.dart';

sealed class RegistrationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegistrationEmailChanged extends RegistrationEvent {
  final String email;

  RegistrationEmailChanged({required this.email});

  @override
  List<Object?> get props => [email];
}

class RegistrationPasswordChanged extends RegistrationEvent {
  final String password;

  RegistrationPasswordChanged({required this.password});

  @override
  List<Object?> get props => [password];
}

class RegistrationRegisterButtonClicked extends RegistrationEvent {
  RegistrationRegisterButtonClicked();
}
