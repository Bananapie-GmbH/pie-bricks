import 'package:bloc/bloc.dart';
part 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(BottomNavigationState(index: 0));

  setIndex(int index, {dynamic data}) {
    emit(
      state.copyWith(
        index: index,
        data: () => data,
      ),
    );
  }

  setData({dynamic data}) {
    emit(
      state.copyWith(
        data: () => data,
      ),
    );
  }
}
