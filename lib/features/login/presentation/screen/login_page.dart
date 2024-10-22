import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/core/di/dependency_injection.dart';
import 'package:notes/core/navigation/routes/registration_route.dart';
import '../../../../core/ui/widgets/text_field/login_text_fields.dart';
import '../../../../generated/l10n.dart';
import '../bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginBloc>(),
      child: const _LoginScreen(),
    );
  }
}

class _LoginScreen extends StatelessWidget {
  const _LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    return BlocListener<LoginBloc, LoginState>(
      listenWhen: (previous, current) =>
          previous.isSuccessfullySignedIn != current.isSuccessfullySignedIn ||
          previous.isNotesListEmpty != current.isNotesListEmpty,
      listener: (context, state) {
        if (state.isSuccessfullySignedIn) {
          if (state.isNotesListEmpty) {
            context.pop();
          } else {
            showDialog(context: context, builder: (context) => _SaveLocalDataDialog(bloc: bloc));
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Login'),
        ),
        body: const _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.isLoading != current.isLoading,
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const Align(
          heightFactor: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: _EmailField(),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: _PasswordField(),
              ),
              SizedBox(height: 40),
              _SignInButton(),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _RegisterButton(),
                  _GoogleIcon(),
                  _AppleButton(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.email != current.email || previous.emailTextError != current.emailTextError,
      builder: (context, state) {
        return CustomTextField(
          errorText: state.emailTextError,
          labelText: S.of(context).email,
          onChanged: (value) => bloc.add(LoginEmailChanged(email: value)),
        );
      },
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (current, previous) =>
          previous.password != current.password ||
          previous.passwordTextError != current.passwordTextError,
      builder: (context, state) {
        return CustomTextField(
          labelText: S.of(context).password,
          errorText: state.passwordTextError,
          needObscureText: true,
          onChanged: (value) => bloc.add(
            LoginPasswordChanged(password: value),
          ),
        );
      },
    );
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prev, curr) =>
          prev.email != curr.email ||
          prev.password != curr.password ||
          prev.emailTextError != curr.emailTextError ||
          prev.passwordTextError != curr.passwordTextError,
      builder: (context, state) {
        final isEmailEmpty = state.email.isEmpty;
        final isPasswordEmpty = state.password.isEmpty;
        final hasError = state.emailTextError != null || state.passwordTextError != null;
        return ElevatedButton(
          onPressed: isEmailEmpty || isPasswordEmpty || hasError
              ? null
              : () {
                  bloc.add(LoginSignInButtonClicked());
                },
          style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(Colors.white),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.black, // your color here
                ),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          child: Text(
            S.of(context).sign_in,
            style: const TextStyle(color: Colors.black),
          ),
        );
      },
    );
  }
}

class _GoogleIcon extends StatelessWidget {
  const _GoogleIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    return IconButton(
      onPressed: () {
        bloc.add(LoginGoogleIconClicked());
      },
      icon: SvgPicture.asset('assets/icons/ic_google.svg'),
    );
  }
}

class _AppleButton extends StatelessWidget {
  const _AppleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    if (!Platform.isIOS) return const SizedBox();
    return IconButton(
      onPressed: () {
        bloc.add(LoginAppleIconClicked());
      },
      icon: const Icon(Icons.apple),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (prev, curr) =>
          prev.email != curr.email ||
          prev.password != curr.password ||
          prev.emailTextError != curr.emailTextError ||
          prev.passwordTextError != curr.passwordTextError,
      builder: (context, state) {
        return TextButton(
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.white),
          ),
          onPressed: () {
            context.go(RegistrationRoute.navigateRoute);
          },
          child: Text(
            S.of(context).create_account,
            style: const TextStyle(color: Colors.blueAccent),
          ),
        );
      },
    );
  }
}

class _SaveLocalDataDialog extends StatelessWidget {
  const _SaveLocalDataDialog({super.key, required this.bloc});

  final LoginBloc bloc;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    return AlertDialog(
      title: Text(S.of(context).save_local_data_title),
      content: Text(S.of(context).save_local_data_description),
      actions: [
        TextButton(
            onPressed: () {
              context.pop();
              bloc.add(SaveLocalDataYesButtonClicked());
            },
            child: Text(S.of(context).button_yes)),
        TextButton(
            onPressed: () {
              context.pop();
              context.pop();
            },
            child: Text(S.of(context).button_no))
      ],
    );
  }
}
