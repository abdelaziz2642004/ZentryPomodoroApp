import 'package:flutter/material.dart';
import 'package:prj/core/colors.dart';

import '../../../../Widgets/HelpingWidgets/CustomContainer.dart';
import 'HelpingWidgets/ControlBadge.dart';
import 'HelpingWidgets/ControlInfo.dart';
import 'HelpingWidgets/CreatorInfo.dart';
import 'HelpingWidgets/JoinButton.dart';
import 'HelpingWidgets/JoinedUsers.dart';
import 'HelpingWidgets/RoomName.dart';
import 'HelpingWidgets/Tags.dart';
import 'HelpingWidgets/WorkBreakView.dart';

class RoomGridItem extends StatelessWidget {
  RoomGridItem({super.key});

  final List<String> tags = ["Test", "Long Test", "UPPER Test", "Don't show"];
  final String roomName = "VERY VERY LONG ROOM NAME TEST TEST TEST";
  final bool isPublic = true;
  final String workTime = "25 min";
  final String breakTime = "5 min";
  final String creatorName = 'takii';
  final int joinedUsers = 20;
  final int roomCapacity = 50;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomContainer(
          color: white,
          blurRadius: 4,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Room Name
                RoomName(roomName: roomName),
                const SizedBox(height: 4),

                /// Creator Info
                CreatorInfo(creatorName: creatorName),
                const SizedBox(height: 8),

                /// Sessions Info
                const SessionInfo(),
                const SizedBox(height: 8),

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
                const SizedBox(height: 8),

                /// Tags
                Tags(tags: tags),
                const SizedBox(height: 8),

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
  }
}
