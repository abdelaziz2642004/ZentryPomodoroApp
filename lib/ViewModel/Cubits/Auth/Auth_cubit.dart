import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/Models/User.dart';
import 'package:prj/ViewModel/Cubits/Auth/Auth_states.dart';
import 'package:prj/ViewModel/Services/LoginService.dart';
import 'package:prj/ViewModel/Services/signUpService.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  late LoginService loginService;
  late Signupservice signupService;

  Future<void> atStart() async {
    emit(AuthInitialState());
    try {
      user = await LoginService.fetchUserData();
      emit(AuthSuccessState());
    } catch (e) {
      emit(AuthErrorState('Login failed'));
    }
  }

  FireUser? user;
  void login(BuildContext context) async {
    emit(AuthLoadingState());

    try {
      await loginService.signIn();
      // fetch user data if login was successful ya m3lm :D
      user = await LoginService.fetchUserData();

      emit(AuthSuccessState());
    } catch (e) {
      emit(AuthErrorState('Login failed'));
      // incase login successful but couldn't fetch user data
    }

    // go fetch the user data :D
  }

  void logout() async {
    emit(AuthLoadingState());
    // Simulate a network call
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      emit(AuthErrorState('Logout failed'));
    }
    emit(AuthInitialState());
  }

  void signUp(BuildContext context) async {
    emit(AuthLoadingState());

    var usernameSnapshot =
        await FirebaseFirestore.instance
            .collection('UserNames')
            .doc(signupService.username)
            .get();

    if (usernameSnapshot.exists) {
      print("username already exists");
      emit(AuthErrorState('Username already exists'));
      return;
    }

    try {
      await signupService.signUp();
      // if succesful , then log out because I dont want the signup to be as login :D
      await FirebaseAuth.instance.signOut();

      emit(AuthSuccessState());
    } catch (e) {
      emit(AuthErrorState('Sign up failed'));
    }

    // Simulate a network calL
  }

  void checkUsernameAvailaibility(String userName) async {
    emit(AuthLoadingState());
    signupService.username = userName;

    if (userName.isEmpty) {
      signupService.usernameError = null;
      return;
    }

    var usernameSnapshot =
        await FirebaseFirestore.instance
            .collection('UserNames')
            .doc(userName)
            .get();
    if (usernameSnapshot.exists) {
      emit(AuthErrorState('Username already exists'));
      signupService.usernameError = 'Username already exists';
    } else {
      signupService.usernameError = null;
      emit(AuthSuccessState());
    }
  }
}
