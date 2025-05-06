import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:lottie/lottie.dart';
import 'package:mime/mime.dart';

class Signupservice {
  final _formKey = GlobalKey<FormState>();
  String? username = '';
  String? fullName = '';
  String _email = '';
  String password = '';
  bool obscurePassword1 = true;
  bool obscurePassword2 = true;
  String? _usernameError;

  get usernameError => this._usernameError;

  set usernameError(value) => this._usernameError = value;
  String? _emailError;
  File? _selectedImage;

  final BuildContext context; // show a successful dialog

  Signupservice({required this.context});

  GlobalKey<FormState> get formKey => _formKey;

  String get email => _email;

  String? get emailError => _emailError;
  File? get selectedImage => _selectedImage;

  Future<String> uploadImageToCloudinary(
    File imageFile,
    UserCredential user,
  ) async {
    final url = Uri.parse(
      'https://api.cloudinary.com/v1_1/dv0opvwfu/image/upload',
    );

    var request =
        http.MultipartRequest('POST', url)
          ..fields['upload_preset'] = 'UsersPics'
          ..fields['public_id'] = user.user!.uid
          // Set a custom name
          ..files.add(
            await http.MultipartFile.fromPath(
              'file',
              imageFile.path,
              contentType: MediaType.parse(
                lookupMimeType(imageFile.path) ?? 'image/jpeg',
              ),
            ),
          );

    var response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await http.Response.fromStream(response);
      return jsonDecode(responseData.body)['secure_url'];
    } else {
      throw Exception('Failed to upload image: ${response.statusCode}');
    }
  }

  void showSuccessPopup() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/JSON/sent.json',
                    width: 300, // Lottie animation
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Account created successfully! Please verify your email.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      // color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
    // Navigator.of(context).pop(); nope
  }

  Future<void> signUp() async {
    //  the collections  must :D exist before querying
    await FirebaseFirestore.instance
        .collection('UserNames')
        .doc('_init')
        .set({});
    await FirebaseFirestore.instance.collection('Users').doc('_init').set({});

    if (_formKey.currentState!.validate()) {
      _emailError = null;
      _usernameError = null;
      // rebuild the parent widget

      // print("I'm here");

      var usernameSnapshot =
          await FirebaseFirestore.instance
              .collection('UserNames')
              .doc(username)
              .get();

      if (usernameSnapshot.exists) {
        _usernameError = 'Username already exists';
        return;
      }

      try {
        final userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: _email.trim(),
              password: password.trim(),
            );
        // print(userCredential.user!.email);
        // print("i'm here");

        String imageUrl = '';
        if (_selectedImage != null) {
          imageUrl = await uploadImageToCloudinary(
            _selectedImage!,
            userCredential,
          ); // in order to await a function , --> Future<type>
          // print("i'm here $imageUrl");
        }
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userCredential.user!.uid)
            .set({
              'username': username!.trim(),
              'fullname': fullName,
              'email': _email.trim(),

              'imageUrl': imageUrl,
              'favorited': [],
              'notifications': [],
            });

        await FirebaseFirestore.instance
            .collection('UserNames')
            .doc(username)
            .set({
              'username': username!.trim(),
              'fullname': fullName,
              'email': _email.trim(),
              'id': userCredential.user!.uid,
            });

        showSuccessPopup();
      } catch (e) {
        if (!context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('An error occurred: ${e.toString()}')),
          );
        }

        // send email verification , will still see if I will include this
        // await userCredential.user!.sendEmailVerification();
        // I need to rehost my old website again and it also need flutter blaze
        // obviously there are other solutions for hosting but I don't have time unfortunately
      }
    }
  }

  // void checkUsername(String userName) async {
  //   if (userName.isEmpty) {
  //     _usernameError = null; // Clear error

  //     return;
  //   }

  //   var usernameSnapshot =
  //       await FirebaseFirestore.instance
  //           .collection('UserNames')
  //           .doc(userName)
  //           .get();
  //   _usernameError = usernameSnapshot.exists ? 'Username already exists' : null;

  //   if (_usernameError == null) {
  //     username = userName;
  //   }
  // }

  Future<void> checkEmail(String email) async {
    // Check if the email exists in the Users collection
    var emailSnapshot =
        await FirebaseFirestore.instance
            .collection('Users')
            .where('email', isEqualTo: email.trim())
            .get();

    _emailError = emailSnapshot.docs.isNotEmpty ? 'Email already exists' : null;

    if (_emailError == null) {
      _email = email;
    }
  }

  void pickImage(File img) {
    _selectedImage = img;
  }
}
