import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/core/navigation/routes/profile_route.dart';
import 'package:notes/core/ui/widgets/text_field/login_text_fields.dart';
import 'package:notes/features/registration/presentation/bloc/registration_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/navigation/routes/login_route.dart';
import '../../../../generated/l10n.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  void popUntilPath(BuildContext context, String routePath) {
    final router = GoRouter.of(context);
    String currentRoute = router.routerDelegate.currentConfiguration.matches.last.matchedLocation;
    while (currentRoute != routePath) {
      if (!context.canPop()) {
        return;
      }
      context.pop();
      currentRoute = router.routerDelegate.currentConfiguration.fullPath;
      print('CURRENT ROUTE ==>> $currentRoute');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegistrationBloc>(),
      child: BlocListener<RegistrationBloc, RegistrationState>(
        listenWhen: (previous, current) =>
            previous.isSuccessfullyRegistered != current.isSuccessfullyRegistered,
        listener: (context, state) {
          if (state.isSuccessfullyRegistered) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: TextButton(
                  onPressed: () {
                    popUntilPath(context, LoginRoute.navigateRoute);
                  },
                  child: Text(S.of(context).ok),
                ),
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text('Registration'),
          ),
          body: const _Body(),
        ),
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
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      buildWhen: (previous, current) => previous.isLoading != current.isLoading,
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const Column(
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
            SizedBox(height: 100),
            _RegisterButton(),
          ],
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
    final bloc = context.read<RegistrationBloc>();
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      buildWhen: (previous, current) =>
          previous.email != current.email || previous.emailTextError != current.emailTextError,
      builder: (context, state) {
        return CustomTextField(
          errorText: state.emailTextError,
          labelText: S.of(context).email,
          onChanged: (value) => bloc.add(RegistrationEmailChanged(email: value)),
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
    final bloc = context.read<RegistrationBloc>();
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      buildWhen: (current, previous) =>
          previous.password != current.password ||
          previous.passwordTextError != current.passwordTextError,
      builder: (context, state) {
        return CustomTextField(
          labelText: S.of(context).password,
          errorText: state.passwordTextError,
          needObscureText: true,
          onChanged: (value) => bloc.add(
            RegistrationPasswordChanged(password: value),
          ),
        );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegistrationBloc>();
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      buildWhen: (prev, curr) =>
          prev.email != curr.email ||
          prev.password != curr.password ||
          prev.emailTextError != curr.emailTextError ||
          prev.passwordTextError != curr.passwordTextError,
      builder: (context, state) {
        final isEmailEmpty = state.email.isEmpty;
        final isPasswordEmpty = state.password.isEmpty;
        final hasError = state.emailTextError != null || state.passwordTextError != null;
        return TextButton(
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
          onPressed: isEmailEmpty || isPasswordEmpty || hasError
              ? null
              : () {
                  bloc.add(RegistrationRegisterButtonClicked());
                  context.pop();
                  context.pop();
                },
          child: Text(
            S.of(context).register,
            style: const TextStyle(color: Colors.black),
          ),
        );
      },
    );
  }
}
