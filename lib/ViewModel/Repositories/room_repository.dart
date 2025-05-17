import 'package:prj/Models/PomodoroRoom.dart';

import '../Services/room_service.dart';

class RoomRepository {
  final RoomService _roomService;

  RoomRepository(this._roomService);

  Future<void> createRoom(PomodoroRoom room) {
    return _roomService.createRoom(room);
  }

  Future<PomodoroRoom?> joinRoom(String roomcode) {
    return _roomService.joinRoom(roomcode);
  }

  Future<void> leaveRoom(String roomCode) {
    return _roomService.leaveRoom(roomCode);
  }
}
