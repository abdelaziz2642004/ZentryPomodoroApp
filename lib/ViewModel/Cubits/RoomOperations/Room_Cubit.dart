import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/Models/PomodoroRoom.dart';
import 'package:prj/Models/User.dart';
import 'package:prj/ViewModel/Cubits/RoomOperations/Room_States.dart';

class RoomCubit extends Cubit<RoomStates> {
  RoomCubit() : super(RoomInitialState());

  Future<void> createRoom(PomodoroRoom room) async {
    emit(RoomLoadingState());
    try {
      print("Creating room with code: ${room.roomCode}");

      // Save room to Firestore
      await FirebaseFirestore.instance
          .collection('rooms')
          .doc(room.roomCode)
          .set(room.toMap());

      // Save room to Realtime Database
      final DatabaseReference roomRef = FirebaseDatabase.instance.ref(
        "Rooms/${room.roomCode}",
      );
      await roomRef.set(room.toMapRealTimeDB());

      print(
        "Room created successfully in both Firestore and Realtime Database",
      );

      emit(RoomCreationSuccess());
    } catch (e) {
      print("Error creating room: $e");
      emit(RoomCreationFailure(e.toString()));
    }
  }

  Future<void> joinRoom(String roomCode, FireUser user) async {
    emit(RoomJoinLoadingState());
    try {
      final DatabaseReference roomRef = FirebaseDatabase.instance.ref(
        "Rooms/$roomCode",
      );
      final DataSnapshot roomSnapshot = await roomRef.get();

      if (roomSnapshot.exists) {
        final DatabaseReference userRef = roomRef.child("users/${user.id}");

        await userRef.set(true); // user is now in the room
        await userRef
            .onDisconnect() // lw el net 2t3 aw 7aga
            .remove();

        final roomData = roomSnapshot.value as Map<dynamic, dynamic>;
        final PomodoroRoom room = PomodoroRoom.fromRealtimeMap(
          roomCode,
          roomData,
        );

        emit(RoomJoinSuccess(room));
      } else {
        emit(RoomJoinFailure("Room does not exist"));
      }
    } catch (e) {
      emit(RoomJoinFailure(e.toString()));
    }
  }

  Future<void> leaveRoom(String roomCode, FireUser user) async {
    emit(RoomJoinLoadingState());
    try {
      // Reference to the user's entry in the Realtime Database
      final DatabaseReference userRef = FirebaseDatabase.instance.ref(
        "Rooms/$roomCode/users/${user.id}",
      );

      // Remove the user from the room
      await userRef.remove();

      // Emit success state
      emit(RoomLeaveSuccess());
    } catch (e) {
      // Emit failure state if an error occurs
      emit(RoomLeaveFailure(e.toString()));
    }
  }

  Future<void> changeInUsers(
    PomodoroRoom room,
    List<String> newJoinedUsers,
  ) async {
    if (room.joinedUsers == newJoinedUsers) {
      return; // no change in the users
    }
    room.joinedUsers = newJoinedUsers;
    emit(
      RoomJoinSuccess(room),
    ); // so we update the details of the joined users every time :D
  }
}
