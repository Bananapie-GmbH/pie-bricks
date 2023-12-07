part of 'home_page_cubit.dart';

@immutable
class HomePageState {
  const HomePageState._({
    required this.isLoading,
  });

  final bool isLoading;

  factory HomePageState.initialize() {
    return const HomePageState._(
      isLoading: true,
    );
  }

  HomePageState copyWith({
    bool? isLoading,
  }) {
    return HomePageState._(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
