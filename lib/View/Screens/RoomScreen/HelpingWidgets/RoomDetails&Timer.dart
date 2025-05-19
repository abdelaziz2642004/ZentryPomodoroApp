import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/View/Screens/RoomScreen/HelpingWidgets/RoomPhaseTimer.dart';
import 'package:prj/ViewModel/Cubits/RoomOperations/Room_Cubit.dart';
import 'package:prj/ViewModel/Cubits/RoomOperations/Room_States.dart';

class RoomDetailsAndTimer extends StatelessWidget {
  const RoomDetailsAndTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomCubit, RoomStates>(
      buildWhen: (previous, current) {
        // Return true only for the specific states you want to rebuild for
        return current is RoomJoinSuccess ||
            current is RoomJoinFailure ||
            current is RoomJoinLoadingState;
      },
      builder: (context, state) {
        if (state is RoomJoinLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RoomJoinFailure) {
          return Center(
            child: Text(
              "Error: ${state.error}",
              style: const TextStyle(color: Colors.red),
            ),
          );////
        } else if (state is RoomJoinSuccess) {
          final roomDetails = state.room;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name: ${roomDetails.name}"),
              Text("Creator: ${roomDetails.creatorId}"),
              Text("Capacity: ${roomDetails.capacity}"),
              Text("JoinedUsers: ${roomDetails.joinedUsers.length}"),
              Text("Work Duration: ${roomDetails.workDuration} mins"),
              Text("Break Duration: ${roomDetails.breakDuration} mins"),
              Text("Public: ${roomDetails.isPublic ? 'Yes' : 'No'}"),
              Text("Total Sessions: ${roomDetails.totalSessions}"),
              Text("CreatedAt: ${roomDetails.createdAt.toDate()}"),
              const SizedBox(height: 12),
              RoomPhaseTimer(
                createdAt: roomDetails.createdAt.toDate(),
                workDuration: roomDetails.workDuration,
                breakDuration: roomDetails.breakDuration,
                totalSessions: roomDetails.totalSessions,
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
