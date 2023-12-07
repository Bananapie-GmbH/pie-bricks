import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      emit(
        state.copyWith(
          isLoading: false,
          userData: FirebaseAuth.instance.currentUser,
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

  Future<void> updateEmail({required String newEmail}) async {
    if (state.isLoading != true) {
      emit(
        state.copyWith(
          isLoading: true,
        ),
      );
    }
    try {
      await FirebaseAuth.instance.currentUser
          ?.verifyBeforeUpdateEmail(newEmail);
      emit(
        state.copyWith(
          isLoading: false,
          userData: FirebaseAuth.instance.currentUser,
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

  Future<void> updateDisplayName({String? displayName}) async {
    if (state.isLoading != true) {
      emit(
        state.copyWith(
          isLoading: true,
        ),
      );
    }
    try {
      await FirebaseAuth.instance.currentUser?.updateDisplayName(displayName);
      emit(
        state.copyWith(
          isLoading: false,
          userData: FirebaseAuth.instance.currentUser,
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
}
