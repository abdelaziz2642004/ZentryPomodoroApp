import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/ViewModel/Cubits/Auth/Auth_cubit.dart';
import 'package:prj/ViewModel/Cubits/RoomOperations/Room_Cubit.dart';

class RoomAppBar {
  static AppBar build(String roomCode, BuildContext context) {
    return AppBar(
      title: const Text("Room"),
      leading: IconButton(
        icon: const Icon(Icons.exit_to_app), // Custom "Leave Room" icon
        onPressed: () async {
          await leaveroom(context, roomCode);
        },
      ),
    );
  }
}

Future<bool> leaveroom(BuildContext context, String roomCode) async {
  // Trigger the same leave confirmation dialog
  final shouldLeave = await showDialog<bool>(
    context: context,
    builder:
        (_) => AlertDialog(
          title: const Text("Leave Room"),
          content: const Text("Are you sure you want to leave the room?"),
          actions: [
            TextButton(
              onPressed:
                  () => Navigator.pop(context, false), // Stay in the room
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true); // Confirm leaving
              },
              child: const Text("Leave"),
            ),
          ],
        ),
  );

  if (shouldLeave == true) {
    // Perform the leave room logic
    final currentUser = BlocProvider.of<AuthCubit>(context).user;
    await BlocProvider.of<RoomCubit>(context).leaveRoom(roomCode, currentUser!);
    Navigator.pop(context);
    return true; // Leave the room
    // Navigate back
  }
  return false; // Stay in the room
}
