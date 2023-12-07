part of 'user_data_cubit.dart';

@immutable
class UserDataState {
  const UserDataState._({
    required this.isLoading,
    this.userData,
  });

  final bool isLoading;
  final User? userData;

  factory UserDataState.initialize() {
    return const UserDataState._(
      isLoading: true,
    );
  }

  UserDataState copyWith({
    bool? isLoading,
    User? userData,
  }) {
    return UserDataState._(
      isLoading: isLoading ?? this.isLoading,
      userData: userData ?? this.userData,
    );
  }
}
