// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:prj/Models/PomodoroRoom.dart';

class RoomService {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
      final PomodoroRoom room = PomodoroRoom.fromRealtimeMap(
        roomCode,
        roomData,
      );

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
}
