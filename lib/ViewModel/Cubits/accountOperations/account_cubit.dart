import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:prj/ViewModel/Cubits/accountOperations/account_states.dart';

class AccountCubit extends Cubit<AccountStates> {
  AccountCubit() : super(accountInitialState());

  Future<void> changePassword(String oldPassword, String newPassword) async {
    emit(accountLoadingState());

    User user = FirebaseAuth.instance.currentUser!;

    try {
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassword,
      );

      await user.reauthenticateWithCredential(credential);
      if (oldPassword == newPassword) {
        // showErrorDialog(
        //   'The new password must be different from the old password.',
        //   context,
        // );

        emit(SameOldPassword());
        return;
      }

      await user.updatePassword(newPassword);

      emit(PasswordSuccess());
      await Future.delayed(const Duration(seconds: 3), () {});
      emit(accountInitialState());
    } catch (e, stackTrace) {
      // _showErrorDialog('Error updating password: $e', context);
      emit(PasswordError('Error updating password: $e , $stackTrace'));
      // Show error for a longer duration
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

      final String idd = currentUser.uid;

      await currentUser.delete();

      final docref = await FirebaseFirestore.instance
          .collection('Users')
          .doc(idd);
      final userName =
          await docref.get().then((doc) => doc['username']) as String;

      await docref.delete();
      await FirebaseFirestore.instance
          .collection('UserNames')
          .doc(userName)
          .get()
          .then((doc) {
            if (doc.exists) {
              doc.reference.delete();
            }
          });
      await FirebaseFirestore.instance
          .collection('UserNames')
          .doc(userName)
          .delete();

      emit(UserDeletionSuccess());
    } catch (error) {
      // print('Error deleting account: $error');
      emit(UserDeletionError(error.toString()));
    }
  }
}
