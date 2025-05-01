import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Models/User.dart';

final userProvider = FutureProvider<user>((ref) async {
  try {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return user();
    }

    print("I got here 1");
    String userId = currentUser.uid;
    print(userId);

    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('Users').doc(userId).get();

    print("I got here 2");

    if (!userDoc.exists) {
      print("I got here 3");

      return user();
    }

    return user(
      notifications: [],
      id: userId,
      email: userDoc['email'] ?? '',
      ImageUrl: userDoc['imageUrl'] ?? '',
      fullName: userDoc['fullname'] ?? '',
    );
  } catch (e) {
    throw Exception("Error fetching user: $e");
  }
});
