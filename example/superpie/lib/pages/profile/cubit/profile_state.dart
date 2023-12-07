part of 'profile_cubit.dart';

@immutable
class ProfileState {
  const ProfileState._({
    required this.isLoading,
  });

  final bool isLoading;

  factory ProfileState.initialize() {
    return const ProfileState._(
      isLoading: true,
    );
  }

  ProfileState copyWith({
    bool? isLoading,
  }) {
    return ProfileState._(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
