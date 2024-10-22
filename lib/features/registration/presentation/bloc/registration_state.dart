part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  final bool isLoading;
  final bool isSuccessfullyRegistered;
  final String email;
  final String password;
  final String? emailTextError;
  final String? passwordTextError;

  const RegistrationState({
    required this.isLoading,
    this.isSuccessfullyRegistered = false ,
    this.email = "",
    this.password = "",
    this.emailTextError,
    this.passwordTextError,
  });

  RegistrationState copyWith({
    bool? isLoading,
    bool? isSuccessfullyRegistered,
    String? email,
    String? password,
    String? Function()? emailTextError,
    String? Function()? passwordTextError,
  }) {
    return RegistrationState(
      isLoading: isLoading ?? this.isLoading,
      isSuccessfullyRegistered: isSuccessfullyRegistered ?? this.isSuccessfullyRegistered,
      email: email ?? this.email,
      password: password ?? this.password,
      emailTextError: emailTextError != null ? emailTextError() : this.emailTextError,
      passwordTextError: passwordTextError != null ? passwordTextError() : this.passwordTextError,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccessfullyRegistered,
        email,
        password,
        emailTextError,
        passwordTextError,
      ];
}
