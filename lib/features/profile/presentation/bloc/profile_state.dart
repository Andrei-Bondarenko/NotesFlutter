part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final User? user;

  const ProfileState({this.user, required this.isLoading});

  ProfileState copyWith({
    User? Function()? user,
    bool? isLoading,
  }) {
    return ProfileState(
      user: user != null ? user() : this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        user,
      ];
}
