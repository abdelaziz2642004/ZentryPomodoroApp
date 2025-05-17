import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prj/Models/User.dart';
import 'package:prj/ViewModel/Services/LoginService.dart';
import 'package:prj/ViewModel/Services/signUpService.dart';

class AuthRepo {
  late LoginService loginService;
  late Signupservice signupservice;

  Future<FireUser> atStart() async {
    return await LoginService.fetchUserData();
  }

  Future<void> signUp() async {
    await signupservice.signUp();
    // if succesful , then log out because I dont want the signup to be as login :D
    await FirebaseAuth.instance.signOut();
  }

  Future<FireUser> login() async {
    await loginService.signIn();
    return await LoginService.fetchUserData();
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<bool> checkUsernameAvailaibility(String userName) async {
    signupservice.username = userName;
    if (userName.isEmpty) {
      signupservice.usernameError = null;
      return true;
    }
    var usernameSnapshot =
        await FirebaseFirestore.instance
            .collection('UserNames')
            .doc(userName)
            .get();
    return usernameSnapshot.exists;
  }
}
