import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/ViewModel/Cubits/Profile/profile_states.dart';
import 'package:prj/ViewModel/Repositories/Profile_Repo.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit(this.profileRepo) : super(ProfileInitialState());

  final ProfileRepo profileRepo;

  Future<void> changeImage(File pickedFile, BuildContext context) async {
    emit(ProfileLoadingState());
    try {
      await profileRepo.changeImage(pickedFile, context);
      emit(ProfileSuccessState());
    } catch (error) {
      emit(ProfileErrorState(error.toString()));
    }
  }

  Future<void> changeFullName(String newName) async {
    emit(ProfileLoadingState());
    try {
      await profileRepo.changeFullName(newName);
      emit(FullNameSuccess());
    } catch (e) {
      emit(FullNameError('Error updating full name: $e'));
    }
  }
}
