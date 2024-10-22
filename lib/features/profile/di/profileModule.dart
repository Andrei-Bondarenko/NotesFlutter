import 'package:notes/core/di/dependency_injection.dart';
import 'package:notes/features/profile/presentation/bloc/profile_bloc.dart';

void initProfileModule() {
  getIt.registerFactory(() => ProfileBloc(authInteractor: getIt(), noteInteractor: getIt()));
}
