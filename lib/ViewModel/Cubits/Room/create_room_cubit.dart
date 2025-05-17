import 'package:bloc/bloc.dart';
import '../../../Models/PomodoroRoom.dart';
import 'package:flutter/material.dart';

import '../../Repositories/room_repository.dart';

part 'create_room_state.dart';

class CreateRoomCubit extends Cubit<CreateRoomState> {
  final RoomRepository roomRepository;

  CreateRoomCubit(this.roomRepository) : super(CreateRoomInitial());

  Future<void> createRoom({required PomodoroRoom? room}) async {
    emit(CreateRoomLoading());

    try {
      if (room == null) {
        throw ("Not Valid input");
      }
      DateTime createdAt = room.createdAt.toDate();
      DateTime scheduleTime = room.scheduleTime.toDate();

      if (room.isScheduled && createdAt.isAfter(scheduleTime)) {
        throw ("Scheduler must be AFTER created time");
      }
      await roomRepository.createRoom(room);

      emit(CreateRoomSuccess());
    } catch (e) {
      emit(CreateRoomFailure(e.toString()));
    }
  }

  void updateWorkDuration(int value) {}
}
