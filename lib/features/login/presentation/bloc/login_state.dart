part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final bool isSuccessfullySignedIn;
  final bool isNotesListEmpty;
  final String email;
  final String password;
  final String? emailTextError;
  final String? passwordTextError;
  final List<Note> notesList;

  const LoginState({
    required this.isLoading,
    this.isSuccessfullySignedIn = false,
    this.isNotesListEmpty = false,
    this.email = "",
    this.password = "",
    this.emailTextError,
    this.passwordTextError,
    this.notesList = const [],
  });

  LoginState copyWith({
    bool? isLoading,
    bool? isSuccessfullySignedIn,
    bool? isNotesListEmpty,
    String? email,
    String? password,
    String? Function()? emailTextError,
    String? Function()? passwordTextError,
    List<Note>? notesList,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isSuccessfullySignedIn: isSuccessfullySignedIn ?? this.isSuccessfullySignedIn,
      isNotesListEmpty: isNotesListEmpty ?? this.isNotesListEmpty,
      email: email ?? this.email,
      password: password ?? this.password,
      emailTextError: emailTextError != null ? emailTextError() : this.emailTextError,
      passwordTextError: passwordTextError != null ? passwordTextError() : this.passwordTextError,
      notesList: notesList ?? this.notesList,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccessfullySignedIn,
        isNotesListEmpty,
        email,
        password,
        emailTextError,
        passwordTextError,
        notesList,
      ];
}
