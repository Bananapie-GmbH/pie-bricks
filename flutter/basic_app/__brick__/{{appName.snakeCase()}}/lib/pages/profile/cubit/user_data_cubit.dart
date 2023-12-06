import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user_data/user_data.dart';
import '../../../services/authentication.service.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit()
      : super(
          UserDataState.initialize(),
        );

  void fetchUserData() async {
    if (state.isLoading != true) {
      emit(
        state.copyWith(
          isLoading: true,
        ),
      );
    }
    try {
      final userDataResponse = await useAuthenticationService().me();

      emit(
        state.copyWith(
          isLoading: false,
          userData: userDataResponse,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
        ),
      );
    }
  }

  Future<void> updateUserData({
    String? firstname,
    String? lastname,
    String? email,
    String? phone,
    String? address,
    String? birthday,
  }) async {
    try {
      final userDataResponse = await useAuthenticationService().updateUserData(
        firstname: firstname,
        lastname: lastname,
        email: email,
        phone: phone,
        address: address,
        birthday: birthday,
      );

      emit(
        state.copyWith(
          isLoading: false,
          userData: userDataResponse,
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> convertAnonymous({
    String? firstname,
    String? lastname,
    String? email,
    String? phone,
    String? address,
    String? birthday,
  }) async {
    try {
      final userDataResponse =
          await useAuthenticationService().convertAnonymous(
        firstname: firstname,
        lastname: lastname,
        email: email,
        phone: phone,
        address: address,
        birthday: birthday,
      );

      emit(
        state.copyWith(
          isLoading: false,
          userData: userDataResponse,
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
