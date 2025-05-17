import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:prj/ViewModel/Cubits/accountOperations/account_states.dart';
import 'package:prj/ViewModel/Repositories/AccountOPS_Repo.dart';

class AccountCubit extends Cubit<AccountStates> {
  AccountCubit(this.accountopsRepo) : super(accountInitialState());

  AccountopsRepo accountopsRepo;

  Future<void> changePassword(String oldPassword, String newPassword) async {
    emit(accountLoadingState());
    final User user = FirebaseAuth.instance.currentUser!;

    try {
      await accountopsRepo.authenticate(oldPassword, user);
      if (oldPassword == newPassword) {
        emit(SameOldPassword());
        return;
      }
      await user.updatePassword(newPassword);

      emit(PasswordSuccess());
      await Future.delayed(const Duration(seconds: 3), () {});
      emit(accountInitialState());
    } catch (e, stackTrace) {
      emit(PasswordError('Error updating password: $e , $stackTrace'));
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete your account?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
    if (shouldDelete != true) return;

    try {
      emit(accountLoadingState());

      accountopsRepo.deleteAccount();

      emit(UserDeletionSuccess());
    } catch (error) {
      // print('Error deleting account: $error');
      emit(UserDeletionError(error.toString()));
    }
  }
}
