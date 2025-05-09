import 'package:flutter/material.dart';
import 'package:prj/View/Screens/HomeScreen/HelpingWidgets/CustomAppBar.dart';
import 'package:prj/View/Screens/HomeScreen/HelpingWidgets/CustomDrawer.dart';
import 'package:prj/View/Screens/HomeScreen/HelpingWidgets/RecentlyJoined.dart';
import 'package:prj/View/Screens/HomeScreen/HelpingWidgets/RoomsGridBuilder.dart';
import 'package:prj/View/Screens/HomeScreen/HelpingWidgets/TimeTrackerToday.dart';
import 'package:prj/core/colors.dart';

import '../../Widgets/CreateRoomDialog/CreateRoom.dart';

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
              const Roomsgridbuilder(),

              const SizedBox(height: 24),
              Center(
                child: Text(
                  "Avatar & Creator",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) => CreateRoom(),
                  );
                },
                child: Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
