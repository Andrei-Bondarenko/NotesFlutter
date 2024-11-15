import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/ui/widgets/bottom_nav_bar/notes_bottom_nav_bar.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<HomeCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<AuthBloc>()..add(AuthUserSubscribed()),
          lazy: false,
        ),
      ],
      child: _Body(navigationShell: navigationShell),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
          );
        }
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: NotesBottomNavigationBar(
            navigationShell: navigationShell,
          ),
        );
      },
    );
  }
}
