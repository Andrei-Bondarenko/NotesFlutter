import 'package:notes/core/di/dependency_injection.dart';
import 'package:notes/features/registration/presentation/bloc/registration_bloc.dart';

void initRegistrationModule() {
  getIt.registerFactory(() => RegistrationBloc(authInteractor: getIt()));
}