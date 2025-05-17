import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/Models/PomodoroRoom.dart';
import 'package:prj/Models/User.dart';
import 'package:prj/ViewModel/Cubits/RoomOperations/Room_States.dart';
import 'package:prj/ViewModel/Repositories/room_repository.dart';

class RoomCubit extends Cubit<RoomStates> {
  RoomCubit(this.roomRepository) : super(RoomInitialState());
  PomodoroRoom? recently;
  final RoomRepository roomRepository;

  Future<String> atStart(FireUser user) async {
    emit(RoomJoinLoadingState());

    try {
      final DatabaseReference userRef = FirebaseDatabase.instance.ref(
        "users/${user.id}",
      );

      final DataSnapshot joinedSnapshot =
          await userRef.child("joinedroom").get();
      final DataSnapshot recentSnapshot = await userRef.child("recently").get();

      if (recentSnapshot.exists) {
        final String recentRoomCode = recentSnapshot.value as String;

        final DatabaseReference recentRoomRef = FirebaseDatabase.instance.ref(
          "Rooms/$recentRoomCode",
        );
        final DataSnapshot recentRoomSnap = await recentRoomRef.get();

        if (recentRoomSnap.exists) {
          final roomData = recentRoomSnap.value as Map<dynamic, dynamic>;
          recently = PomodoroRoom.fromRealtimeMap(recentRoomCode, roomData);
        }
      }

      if (joinedSnapshot.exists) {
        final String roomCode = joinedSnapshot.value as String;

        return roomCode;
      } else {
        emit(RoomInitialState());
        return "";
      }
    } catch (e) {
      emit(RoomJoinFailure("Error during startup: ${e.toString()}"));
      return "";
    }
  }

  Future<void> createRoom(PomodoroRoom room) async {
    emit(RoomCreatingLoadingState());
    try {
      DateTime createdAt = room.createdAt.toDate();
      DateTime scheduleTime = room.scheduleTime.toDate();

      if (room.isScheduled && createdAt.isAfter(scheduleTime)) {
        throw ("Scheduler must be AFTER created time");
      }
      await roomRepository.createRoom(room);
      emit(RoomCreationSuccess());
    } catch (e) {
      print("Error creating room: $e");
      emit(RoomCreationFailure(e.toString()));
    }
  }

  Future<void> joinRoom(String roomCode) async {
    emit(RoomJoinLoadingState());
    try {
      final room = await roomRepository.joinRoom(roomCode);
      recently = room;
      emit(RecentlyUpdated());
      if (room == null) return;
      emit(RoomJoinSuccess(room));
    } catch (e) {
      emit(RoomJoinFailure(e.toString()));
    }
  }

  Future<void> leaveRoom(String roomCode) async {
    emit(RoomJoinLoadingState());
    try {
      await roomRepository.leaveRoom(roomCode);

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
