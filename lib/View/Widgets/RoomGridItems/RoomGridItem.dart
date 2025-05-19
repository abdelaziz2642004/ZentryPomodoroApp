import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:prj/Models/PomodoroRoom.dart';
import 'package:prj/core/colors.dart';

import '../HelpingWidgets/CustomContainer.dart';
import 'HelpingWidgets/ControlBadge.dart';
import 'HelpingWidgets/SessionInfo.dart';
import 'HelpingWidgets/CreatorInfo.dart';
import 'HelpingWidgets/JoinButton.dart';
import 'HelpingWidgets/JoinedUsers.dart';
import 'HelpingWidgets/RoomName.dart';
import 'HelpingWidgets/Tags.dart';
import 'HelpingWidgets/WorkBreakView.dart';

class RoomGridItem extends StatelessWidget {
  PomodoroRoom room;

  RoomGridItem({super.key, required this.room});

  Future<String> fetchCreatorName(String creatorId) async {
    try {
      final doc = await FirebaseFirestore.instance
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

  @override
  Widget build(BuildContext context) {
    final List<String> tags = room.tags;
    final String roomName = room.name;
    final bool isPublic = room.isPublic;
    final String workTime = "${room.workDuration} min";
    final String breakTime = "${room.breakDuration} min";
    final String creatorId = room.creatorId;
    final int joinedUsers = room.joinedUsers.length;
    final int roomCapacity = room.capacity;
    final int numberOfSessions = room.totalSessions;


    return FutureBuilder<String?>(
      future: fetchCreatorName(creatorId),
      builder: (context, snapshot) {
        final creatorName =
            snapshot.connectionState == ConnectionState.done && snapshot.hasData
                ? snapshot.data!
                : "Loading...";
        return Stack(
          children: [
            CustomContainer(
              color: Colors.white,
              blurRadius: 4,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 18, bottom: 12),
                child: Column(
                  //mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Room Name
                    RoomName(roomName: roomName),
                    const SizedBox(height: 4),

                    /// Creator Info
                    CreatorInfo(creatorName: creatorName),
                    const SizedBox(height: 8),

                    /// Sessions Info
                    SessionInfo(numberOfSessions: numberOfSessions,),
                    const SizedBox(height: 12),

                    /// Work & Break Time
                    WorkBreakView(
                      time: workTime,
                      icon: Icons.work,
                      iconColor: Colors.blueAccent,
                      title: "Work Time: ",
                    ),
                    const SizedBox(height: 4),
                    WorkBreakView(
                      time: breakTime,
                      icon: Icons.coffee,
                      iconColor: Colors.orange,
                      title: "Break Time: ",
                    ),

                    /// Tags
                    Tags(tags: tags),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Joined Users
                        JoinedUsers(
                          joinedUsers: joinedUsers,
                          roomCapacity: roomCapacity,
                        ),
                        const SizedBox(width: 15),

                        /// Join Button
                        const JoinButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            /// Control Badge
            ControlBadge(isPublic: isPublic),
          ],
        );
      },
    );
  }
}
