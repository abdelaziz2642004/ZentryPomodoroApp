import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prj/View/Screens/RoomScreen/RoomScreen.dart';

class Roomsgridbuilder extends StatelessWidget {
  const Roomsgridbuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder:
          (context, index) => GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RoomScreen(roomCode: "room1"),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  "Room ${index + 1}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
    );
  }
}
