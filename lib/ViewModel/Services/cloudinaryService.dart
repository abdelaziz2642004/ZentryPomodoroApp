import 'dart:io';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// will need a whole other cubit just for profile Options :D

class CloudinaryService {
  // I KNOW THIS IS REALLY BAD AND COMPLETELY UNSECURE , but i have no idea what to do
  // so I will definitely come back later to do this differently , just working on the functionality right now.
  static const String cloudName = "dv0opvwfu";
  static const String apiKey = "141946341514187";
  static const String apiSecret = "-LpCQkZjIOyOu2-cSQqE9Qe6HNE";
  static const String uploadPreset = "UsersPics";

  static Future<String> pickAndUploadImage(File pickedFile) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) return "";
    try {} catch (e) {
      print("image didn't get deleted tho :D :(");
    }

    try {
      // Step 2: Upload new image
      String? imageUrl = await _uploadImage(pickedFile, currentUser.uid);
      if (imageUrl != null) {
        // Step 3: Update Firestore
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUser.uid)
            .update({'imageUrl': imageUrl});
        return imageUrl;
        // return imageUrl;

        // print("✅ Image uploaded and Firestore updated successfully!");
      } else {
        // print("❌ Image upload failed.");
        return "";
      }
    } catch (e) {
      // print("❌ Error: $e");
      return "";
    }
    // return '';
  }

  static Future<String?> _uploadImage(File file, String publicId) async {
    Cloudinary cloudinary = Cloudinary.full(
      cloudName: cloudName,
      apiKey: apiKey,
      apiSecret: apiSecret,
    );
    CloudinaryUploadResource cloudinaryUploadResource =
        CloudinaryUploadResource(publicId: publicId, filePath: file.path);
    CloudinaryResponse cloudinaryResponse = await cloudinary.uploadResource(
      cloudinaryUploadResource,
    );

    return cloudinaryResponse.url;
  }
}
