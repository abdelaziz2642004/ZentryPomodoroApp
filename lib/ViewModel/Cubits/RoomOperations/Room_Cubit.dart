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
    emit(RoomLoadingState());

    try {
      final room = await roomRepository.recentlyFetch();
      if (room != null) {
        recently = room;
        emit(RecentlyUpdated());
      }

      final joinedRoomCode = await roomRepository.joinedRoomFetch();
      if (joinedRoomCode == null || joinedRoomCode == "") {
        emit(RoomInitialState());
        return "";
      } else {
        emit(RoomInitialState());

        return joinedRoomCode;
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
