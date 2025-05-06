import 'package:flutter/material.dart';
import 'package:prj/View/Screens/HomeScreen/HelpingWidgets/profileAvatar.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [ProfileAvatar()],
              ),
            ),

            Expanded(child: SingleChildScrollView(child: Column(children: [
                  ],
                ))),
          ],
        ),
      ),
    );
  }
}
