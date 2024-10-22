import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/features/home/presentation/bloc/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState(index: 0));

  void changeBottomNavBar(int index) {
    emit(state.copyWith(index));
  }
}