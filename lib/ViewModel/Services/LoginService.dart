import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prj/Models/User.dart';

class LoginService {
  final formKey = GlobalKey<FormState>();
  String emailOrUsername = '';
  String password = '';
  bool obscurePassword = true;

  final BuildContext context; // show a successful dialog

  LoginService({required this.context});

  Future<void> signIn() async {
    if (formKey.currentState!.validate()) {
      //log in :D

      String input = emailOrUsername.trim();
      try {
        if (!input.contains('@')) {
          final snapshot =
              await FirebaseFirestore.instance
                  .collection('UserNames')
                  .doc(input)
                  .get();

          if (snapshot.exists) {
            input = snapshot.data()!['email'];
          }
        }

        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: input,
          password: password.trim(),
        );
        // this will happen if logged in successfully
        // ref.invalidate(userProvider);
      } catch (e) {
        // print(e);
        _showErrorDialog(e.toString());
      }
    }
  }

  void _showErrorDialog(String message) {
    if (!context.mounted) return; // Check if the widget is still mounted
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Login Failed'),
            content: Text(message),
            actions: [
              TextButton(
                child: const Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
    );
  }

  static Future<FireUser> fetchUserData() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        return FireUser();
      }

      String FireUserId = currentUser.uid;
      DocumentSnapshot FireUserDoc =
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(FireUserId)
              .get();
      if (!FireUserDoc.exists) {
        return FireUser();
      }
      return FireUser(
        notifications: [],
        id: FireUserId,
        email: FireUserDoc['email'] ?? '',
        ImageUrl: FireUserDoc['imageUrl'] ?? '',
        fullName: FireUserDoc['fullname'] ?? '',
      );
    } catch (e) {
      throw Exception("Error fetching FireUser: $e");
    }
  }
}
