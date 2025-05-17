import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/Models/User.dart';
import 'package:prj/ViewModel/Cubits/Auth/Auth_states.dart';
import 'package:prj/ViewModel/Cubits/RoomOperations/Room_Cubit.dart';
import 'package:prj/ViewModel/Repositories/Auth_Repo.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitialState());

  final AuthRepo authRepo;
  FireUser? user;

  Future<void> atStart() async {
    emit(AuthInitialState());
    try {
      user = await authRepo.atStart();
      emit(AuthSuccessState());
    } catch (e) {
      emit(AuthErrorState('Login failed'));
    }
  }

  Future<void> login(BuildContext context) async {
    emit(AuthLoadingState());

    try {
      user = await authRepo.login();

      emit(AuthSuccessState());
    } catch (e) {
      emit(AuthErrorState('Login failed'));
    }
  }

  Future<void> logout(BuildContext context) async {
    emit(AuthLoadingState());
    // Simulate a network call
    try {
      await authRepo.logout();
      user = FireUser();
      BlocProvider.of<RoomCubit>(context).recently = null;
      emit(AuthSuccessState());
    } catch (e) {
      emit(AuthErrorState('Logout failed'));
    }
    emit(AuthInitialState());
  }

  Future<void> signUp() async {
    emit(AuthLoadingState());
    final error = await authRepo.checkUsernameAvailaibility(
      authRepo.signupservice.username ?? "1",
    );
    if (error) {
      emit(AuthErrorState('Username already exists'));
      return;
    }
    try {
      await authRepo.signUp();
      emit(AuthSuccessState());
    } catch (e) {
      emit(AuthErrorState('Sign up failed'));
    }
  }

  void checkUsernameAvailaibility(String userName) async {
    emit(AuthLoadingState());

    final error = await authRepo.checkUsernameAvailaibility(userName);
    if (error) {
      emit(AuthErrorState('Username already exists Or Error'));
      authRepo.signupservice.usernameError = 'Username already exists Or Error';
    } else {
      authRepo.signupservice.usernameError = null;
      emit(AuthSuccessState());
    }
  }
}
