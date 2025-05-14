import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:prj/View/Screens/RoomScreen/RoomScreen.dart';
import 'package:prj/ViewModel/Cubits/RoomOperations/Room_Cubit.dart';

class Recentlyjoined extends StatelessWidget {
  const Recentlyjoined({super.key});

  @override
  Widget build(BuildContext context) {
    final room = BlocProvider.of<RoomCubit>(context).recently;
    if (room == null) {
      return Container();
    }

    final DatabaseReference usersRef = FirebaseDatabase.instance
        .ref()
        .child('rooms')
        .child(room.roomCode)
        .child('users');

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RoomScreen(roomCode: room.roomCode),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    room.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  StreamBuilder<DatabaseEvent>(
                    stream: usersRef.onValue,
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data!.snapshot.value != null) {
                        final data = snapshot.data!.snapshot.value as Map;
                        final userCount = data.length;
                        return Text(
                          "$userCount/30 active",
                          style: const TextStyle(color: Colors.grey),
                        );
                      } else {
                        return const Text(
                          "0/30 active",
                          style: TextStyle(color: Colors.grey),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
