import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prj/core/colors.dart';

class CreatorInfo extends StatelessWidget {
  const CreatorInfo({super.key, required this.creatorId});

  final String creatorId;

  Future<String> fetchCreatorName(String creatorId) async {
    try {
      final doc =
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(creatorId)
              .get();

      if (doc.exists) {
        final data = doc.data();
        if (data != null && data.containsKey('username')) {
          return data['username'] as String;
        }
      }
    } catch (e) {
      print("Error fetching username: $e");
    }
    return "Unknown";
  }

  Future<String?> fetchCreatorImage(String creatorId) async {
    try {
      final doc =
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(creatorId)
              .get();

      if (doc.exists) {
        final data = doc.data();
        if (data != null && data.containsKey('imageUrl')) {
          String imageUrl = data['imageUrl'].toString();
          return imageUrl == ""? null : imageUrl;
        }
      }
    } catch (e) {
      print("Error fetching Profile Image: $e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: grey,
          radius: 12,
          child: FutureBuilder<String?>(
            future: fetchCreatorImage(creatorId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: mainColor,
                  ),
                );
              }

              if (snapshot.hasData && snapshot.data != null) {
                return CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: CachedNetworkImageProvider(snapshot.data!),
                );
              }

              return const CircleAvatar(
                radius: 10,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, size: 12, color: Colors.white),
              );
            },
          ),
        ),
        const SizedBox(width: 4),
        FutureBuilder<String?>(
          future: fetchCreatorName(creatorId),
          builder: (context, snapshot) {
            final creatorName =
                snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData
                    ? snapshot.data!
                    : "Loading...";

            return Text(
              "by $creatorName",
              style: const TextStyle(fontSize: 10, color: Colors.black54),
            );
          },
        ),
      ],
    );
  }
}
