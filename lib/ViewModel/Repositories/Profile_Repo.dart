import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/ViewModel/Cubits/Auth/Auth_cubit.dart';
import 'package:prj/ViewModel/Services/cloudinaryService.dart';

class ProfileRepo {
  ProfileRepo(this.cloudinaryService);

  final CloudinaryService cloudinaryService;
  Future<void> changeImage(File pickedFile, BuildContext context) async {
    String imageUrl = await CloudinaryService.pickAndUploadImage(pickedFile);
    BlocProvider.of<AuthCubit>(context).user?.ImageUrl = imageUrl;
  }

  Future<void> changeFullName(String newName) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    await FirebaseFirestore.instance.collection('Users').doc(user.uid).update({
      'fullname': newName,
    });
  }
}
