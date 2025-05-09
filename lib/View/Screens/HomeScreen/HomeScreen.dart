import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/Models/PomodoroRoom.dart';
import 'package:prj/View/Screens/HomeScreen/HelpingWidgets/CustomAppBar.dart';
import 'package:prj/View/Screens/HomeScreen/HelpingWidgets/CustomDrawer.dart';
import 'package:prj/View/Screens/HomeScreen/HelpingWidgets/RecentlyJoined.dart';
import 'package:prj/View/Screens/HomeScreen/HelpingWidgets/RoomsGridBuilder.dart';
import 'package:prj/View/Screens/HomeScreen/HelpingWidgets/TimeTrackerToday.dart';
import 'package:prj/ViewModel/Cubits/Auth/Auth_cubit.dart';
import 'package:prj/ViewModel/Cubits/RoomOperations/Room_Cubit.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Customdrawer(),
      appBar: Customappbar.build(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Timetrackertoday(),

              ElevatedButton(
                onPressed: () async {
                  final id = BlocProvider.of<AuthCubit>(context).user!.id;
                  PomodoroRoom room = PomodoroRoom(
                    // roomCode: "123456", // it will be created wit uuid
                    name: "Test Room",
                    workDuration: 1,
                    breakDuration: 5,
                    totalSessions: 4,
                    createdAt: Timestamp.now(),
                    creatorId: id,
                    availableRoom: true,
                    capacity: 43,
                    isPublic: false,
                    tags: ["test", "room"],
                    joinedUsers: [],
                  );
                  await BlocProvider.of<RoomCubit>(context).createRoom(room);
                },
                child: const Text("Create Random Test Room"),
              ),

              const SizedBox(height: 24),

              const Text(
                "Recently Joined",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Recentlyjoined(),

              const SizedBox(height: 24),

              // Rooms Grid
              const Text(
                "Public Rooms",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const RoomsGridBuilder(),

              const SizedBox(height: 24),
              Center(
                child: Text(
                  "Avatar & Creator",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
