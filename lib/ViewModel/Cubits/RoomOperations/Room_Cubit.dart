import 'package:cloud_firestore/cloud_firestore.dart';
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
      await FirebaseFirestore.instance
          .collection('rooms')
          .doc(room.roomCode)
          .set(room.toMap());

      print("Room created successfully");

      emit(RoomCreationSuccess());
    } catch (e) {
      print("Error creating room: $e");
      emit(RoomCreationFailure(e.toString()));
    }
  }

  Future<void> joinRoom(String roomCode, FireUser user) async {
    emit(RoomJoinLoadingState());
    try {
      final snapshot = FirebaseFirestore.instance
          .collection('rooms')
          .doc(roomCode);
      final doc = await snapshot.get();

      if (doc.exists) {
        // actually join and add the user
        await snapshot.collection('users').doc(user.id).set(user.toMap());

        emit(RoomJoinSuccess(PomodoroRoom.fromDocument(doc)));
        return;
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
      final snapshot = FirebaseFirestore.instance
          .collection('rooms')
          .doc(roomCode);
      final doc = await snapshot.get();
      print("iM HERE");

      if (doc.exists) {
        //delete the user from there
        await snapshot.collection('users').doc(user.id).delete();

        emit(RoomLeaveSuccess());
        return;
      } else {
        emit(RoomLeaveFailure("Couldn't leave the room"));
      }
    } catch (e) {
      emit(RoomLeaveFailure(e.toString()));
    }
  }

  Future<void> changeInUsers(
    PomodoroRoom room,
    List<String> newJoinedUsers,
  ) async {
    room.joinedUsers = newJoinedUsers;
    emit(
      RoomJoinSuccess(room),
    ); // so we update the details of the joined users every time :D
  }
}
