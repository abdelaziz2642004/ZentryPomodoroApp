import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/ViewModel/Cubits/Profile/profile_states.dart';
import 'package:prj/ViewModel/Cubits/Auth/Auth_cubit.dart';
import 'package:prj/ViewModel/Services/cloudinaryService.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());

  Future<void> changeImage(File pickedFile, BuildContext context) async {
    emit(ProfileLoadingState());
    try {
      String imageUrl = await CloudinaryService.pickAndUploadImage(pickedFile);
      BlocProvider.of<AuthCubit>(context).user?.ImageUrl = imageUrl;

      emit(ProfileSuccessState());
    } catch (error) {
      emit(ProfileErrorState(error.toString()));
    }
  }

  Future<void> changeFullName(String newName) async {
    emit(ProfileLoadingState());

    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'fullname': newName});

      emit(FullNameSuccess());
    } catch (e) {
      emit(FullNameError('Error updating full name: $e'));
    }
  }
}
