import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountopsRepo {
  Future<void> authenticate(String oldPassword, User user) async {
    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: oldPassword,
    );

    await user.reauthenticateWithCredential(credential);
  }

  Future<void> deleteAccount() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;
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
  }
}
