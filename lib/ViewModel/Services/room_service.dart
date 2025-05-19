// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:prj/Models/PomodoroRoom.dart';

class RoomService {
  final DatabaseReference _roomsRef = FirebaseDatabase.instance.ref('rooms');
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<dynamic, dynamic>?> recentlyFetch() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;
    final DatabaseReference userRef = FirebaseDatabase.instance.ref(
      "users/${user.uid}",
    );

    // final DataSnapshot joinedSnapshot = await userRef.child("joinedroom").get();
    final DataSnapshot recentSnapshot = await userRef.child("recently").get();
    if (recentSnapshot.exists) {
      final String recentRoomCode = recentSnapshot.value as String;

      final DatabaseReference recentRoomRef = FirebaseDatabase.instance.ref(
        "Rooms/$recentRoomCode",
      );
      final DataSnapshot recentRoomSnap = await recentRoomRef.get();

      if (recentRoomSnap.exists) {
        final roomData = recentRoomSnap.value as Map<dynamic, dynamic>;
        // roomData['roomCode'] = recentRoomCode;
        return roomData;
      }
      return null;
    }
    return null;
  }

  Future<String?> joinedRoomFetch() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    final DatabaseReference userRef = FirebaseDatabase.instance.ref(
      "users/${user.uid}",
    );

    final DataSnapshot joinedSnapshot = await userRef.child("joinedroom").get();

    if (joinedSnapshot.exists) {
      final String roomCode = joinedSnapshot.value as String;

      return roomCode;
    } else {
      return "";
    }
  }

  Future<void> createRoom(PomodoroRoom room) async {
    // await _firestore.collection('rooms').add(room.toMap());

    final DatabaseReference roomRef = FirebaseDatabase.instance.ref(
      "Rooms/${room.roomCode}",
    );
    await roomRef.set(room.toMapRealTimeDB());
  }

  Future<PomodoroRoom?> joinRoom(String roomCode) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    final DatabaseReference roomRef = FirebaseDatabase.instance.ref(
      "Rooms/$roomCode",
    );
    final DataSnapshot roomSnapshot = await roomRef.get();

    if (roomSnapshot.exists) {
      final DatabaseReference userRef = roomRef.child("users/${user.uid}");

      await userRef.set(true); // user is now in the room
      await userRef
          .onDisconnect() // lw el net 2t3 aw 7aga
          .remove();

      // Add joined room to Realtime Database under users/{userID}/joinedroom
      final userDbRef = FirebaseDatabase.instance.ref("users/${user.uid}");

      // Set the recently joined room in Realtime Database (persistent)
      await userDbRef.child("recently").set(roomCode);

      // Set the joined room in Realtime Database (disconnectable)
      await userDbRef.child("joinedroom").set(roomCode);
      await userDbRef
          .child("joinedroom")
          .onDisconnect()
          .remove(); // Remove on disconnect

      final roomData = roomSnapshot.value as Map<dynamic, dynamic>;
      // roomData['roomCode'] = roomCode;
      final PomodoroRoom room = PomodoroRoom.fromRealtimeMap(roomData);

      return room;
    } else {
      return null;
    }
  }

  Future<void> leaveRoom(String roomCode) async {
    // Reference to the user's entry in the Realtime Database
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final DatabaseReference userRef = FirebaseDatabase.instance.ref(
      "Rooms/$roomCode/users/${user.uid}",
    );

    // Remove the user from the room
    await userRef.remove();

    final DatabaseReference userRef2 = FirebaseDatabase.instance.ref(
      "users/${user.uid}",
    );

    userRef2.child("joinedroom").remove();
  }


  // Future<List<PomodoroRoom>> fetchAllRooms() async {
  //   final roomsSnap = await _roomsRef.get();
  //
  //   if (roomsSnap.exists) {
  //     final List roomsSnapList = roomsSnap.value as List<dynamic>;
  //     final List<PomodoroRoom> roomsList =
  //         roomsSnapList.map((roomSnap) {
  //           return PomodoroRoom.fromDocument(roomSnap);
  //         }).toList();
  //
  //     return roomsList;
  //   } else {
  //     return [];
  //   }
  // }
}
