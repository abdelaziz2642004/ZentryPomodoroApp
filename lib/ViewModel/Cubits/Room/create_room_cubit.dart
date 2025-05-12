import 'package:bloc/bloc.dart';
import '../../../Models/PomodoroRoom.dart';
import 'package:flutter/material.dart';

import '../../Repositories/room_repository.dart';

part 'create_room_state.dart';

class CreateRoomCubit extends Cubit<CreateRoomState> {
  final RoomRepository roomRepository;

  CreateRoomCubit(this.roomRepository) : super(CreateRoomInitial());

  Future<void> createRoom({
    required PomodoroRoom room
  }) async {
    emit(CreateRoomLoading());

    try {
      await roomRepository.createRoom(room);

      emit(CreateRoomSuccess());
    } catch (e) {
      emit(CreateRoomFailure(e.toString()));
    }
  }
}
