import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/ViewModel/Cubits/RoomOperations/Room_Cubit.dart';
import 'package:prj/ViewModel/Cubits/RoomOperations/Room_States.dart';

class Joineduserspart extends StatelessWidget {
  const Joineduserspart({super.key, required this.roomCode});

  final String roomCode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomCubit, RoomStates>(
      builder: (context, state) {
        if (state is RoomJoinSuccess) {
          final roomDetails = state.room;
          return StreamBuilder<DatabaseEvent>(
            stream:
                FirebaseDatabase.instance.ref("Rooms/$roomCode/users").onValue,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }
              if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
                return const Text("No users in this room.");
              }

              // Parse the users from the Realtime Database
              final Map<dynamic, dynamic> usersMap =
                  snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

              final userIds = usersMap.keys.toList().cast<String>();

              // Update the RoomCubit with the new list of users
              BlocProvider.of<RoomCubit>(
                context,
              ).changeInUsers(roomDetails, userIds);

              return Column(
                children:
                    userIds.map((userId) {
                      return StreamBuilder<DocumentSnapshot>(
                        stream:
                            FirebaseFirestore.instance
                                .collection('Users')
                                .doc(userId)
                                .snapshots(),
                        builder: (context, userSnapshot) {
                          if (userSnapshot.hasError) {
                            return ListTile(
                              title: Text(
                                "Error loading user: ${userSnapshot.error}",
                              ),
                            );
                          }
                          if (!userSnapshot.hasData ||
                              !userSnapshot.data!.exists) {
                            return const ListTile(
                              title: Text("User not found"),
                            );
                          }

                          // Parse the user data from Firestore
                          final userData =
                              userSnapshot.data!.data() as Map<String, dynamic>;
                          final userName =
                              userData['fullname'] ?? 'Unknown User';
                          final userImage = userData['imageUrl'] ?? '';

                          return ListTile(
                            leading:
                                userImage.isNotEmpty
                                    ? CircleAvatar(
                                      backgroundImage: NetworkImage(userImage),
                                    )
                                    : const CircleAvatar(
                                      child: Icon(Icons.person),
                                    ),
                            title: Text(userName),
                          );
                        },
                      );
                    }).toList(),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
