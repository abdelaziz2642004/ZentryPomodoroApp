import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:prj/Models/PomodoroRoom.dart';
import 'package:prj/View/Screens/RoomScreen/RoomScreen.dart';

import 'RoomGridItems/RoomGridItem.dart';

class RoomsGridBuilder extends StatelessWidget {
  const RoomsGridBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
      stream: FirebaseDatabase.instance.ref("Rooms").onValue,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
          return const Center(child: Text("No public rooms available."));
        }

        // Parse the data from Realtime Database
        final Map<dynamic, dynamic> roomsMap =
            snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

        // Convert the map to a list of PomodoroRoom objects
        final publicRooms =
            roomsMap.entries
                .map((entry) => PomodoroRoom.fromRealtimeMap(entry.value))
                .where((room) => room.isPublic)
                .toList();

        if (publicRooms.isEmpty) {
          return const Center(child: Text("No public rooms available."));
        }
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 6,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.64,
            crossAxisSpacing: 12,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) => RoomGridItem(),
        );
      },
    );
  }
}
