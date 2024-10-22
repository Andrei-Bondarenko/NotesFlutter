import 'package:notes/core/di/dependency_injection.dart';
import 'package:notes/features/home/presentation/bloc/home_cubit.dart';

void initHomeModule() {
  getIt.registerFactory(() => HomeCubit());
}