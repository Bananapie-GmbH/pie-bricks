part of 'bottom_navigation_cubit.dart';

class BottomNavigationState {
  int? index;
  dynamic data;

  BottomNavigationState({
    this.index,
    this.data,
  });

  BottomNavigationState copyWith({int? index, dynamic Function()? data}) {
    return BottomNavigationState(
      index: index ?? this.index,
      data: data != null ? data.call() : this.data,
    );
  }
}
