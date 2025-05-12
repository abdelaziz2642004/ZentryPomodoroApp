import 'package:prj/Models/PomodoroRoom.dart';

import '../Services/room_service.dart';

class RoomRepository {
  final RoomService _roomService;

  RoomRepository(this._roomService);

  Future<void> createRoom(PomodoroRoom room) {
    return _roomService.createRoom(room);
  }
}
