import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prj/ViewModel/Cubits/Auth/Auth_cubit.dart';
import 'package:prj/ViewModel/Cubits/RoomOperations/Room_Cubit.dart';
import 'package:prj/ViewModel/Cubits/RoomOperations/Room_States.dart';
import 'package:prj/core/functions.dart';

class RoomScreen extends StatelessWidget {
  final String roomCode;

  const RoomScreen({Key? key, required this.roomCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = BlocProvider.of<AuthCubit>(context).user;

    return BlocProvider(
      create: (context) => RoomCubit()..joinRoom(roomCode, currentUser!),
      child: Builder(
        builder: (blocContext) {
          return BlocListener<RoomCubit, RoomStates>(
            listenWhen:
                (previous, current) =>
                    current is RoomLeaveSuccess || current is RoomLeaveFailure,
            listener: (context, state) {
              if (state is RoomLeaveSuccess) {
                Navigator.pop(context);
              } else if (state is RoomLeaveFailure) {
                showDialog(
                  context: context,
                  builder:
                      (_) => AlertDialog(
                        title: const Text("Error"),
                        content: Text(state.error),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Try Again"),
                          ),
                        ],
                      ),
                );
              }
            },
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Room"),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.exit_to_app),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (_) => AlertDialog(
                              title: const Text("Leave Room"),
                              content: const Text(
                                "Are you sure you want to leave the room?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context); // Close dialog
                                    await BlocProvider.of<RoomCubit>(
                                      // to be able to get the data u want :D
                                      blocContext,
                                    ).leaveRoom(roomCode, currentUser!);
                                  },
                                  child: const Text("Leave"),
                                ),
                              ],
                            ),
                      );
                    },
                  ),
                ],
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Room Details",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      BlocBuilder<RoomCubit, RoomStates>(
                        builder: (context, state) {
                          if (state is RoomJoinLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is RoomJoinFailure) {
                            return Center(
                              child: Text(
                                "Error: ${state.error}",
                                style: const TextStyle(color: Colors.red),
                              ),
                            );
                          } else if (state is RoomJoinSuccess) {
                            final roomDetails = state.room;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name: ${roomDetails.name}"),
                                Text("Creator: ${roomDetails.creatorId}"),
                                Text("Capacity: ${roomDetails.capacity}"),
                                Text(
                                  "JoinedUsers: ${roomDetails.joinedUsers.length}",
                                ),
                                Text(
                                  "Work Duration: ${roomDetails.workDuration} mins",
                                ),
                                Text(
                                  "Break Duration: ${roomDetails.breakDuration} mins",
                                ),
                                Text(
                                  "Public: ${roomDetails.isPublic ? 'Yes' : 'No'}",
                                ),
                                Text(
                                  "Total Sessions: ${roomDetails.totalSessions}",
                                ),
                                Text(
                                  "Passed Sessions: ${roomDetails.passedSessions}",
                                ),
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Users in Room",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      BlocBuilder<RoomCubit, RoomStates>(
                        builder: (context, state) {
                          if (state is RoomJoinSuccess) {
                            final roomDetails = state.room;
                            return StreamBuilder<QuerySnapshot>(
                              stream:
                                  FirebaseFirestore.instance
                                      .collection('rooms')
                                      .doc(roomCode)
                                      .collection('users')
                                      .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text("Error: ${snapshot.error}"),
                                  );
                                }
                                if (!snapshot.hasData ||
                                    snapshot.data!.docs.isEmpty) {
                                  return const Text("No users in this room.");
                                }

                                final userIds =
                                    snapshot.data!.docs
                                        .map((doc) => doc.id)
                                        .toList();

                                BlocProvider.of<RoomCubit>(
                                  context,
                                ).changeInUsers(roomDetails, userIds);

                                final users = snapshot.data!.docs;

                                return Column(
                                  children:
                                      users.map((userDoc) {
                                        final userData =
                                            userDoc.data()
                                                as Map<String, dynamic>;
                                        final userName =
                                            userData['name'] ?? 'Unknown';
                                        return ListTile(
                                          title: Text(
                                            capitalizeFirstLetterOfEachWord(
                                              userName,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                );
                              },
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
