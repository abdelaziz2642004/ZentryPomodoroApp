import 'package:prj/Models/PomodoroRoom.dart';

import '../Services/room_service.dart';

class RoomRepository {
  final RoomService _roomService;

  RoomRepository(this._roomService);

  Future<void> createRoom(PomodoroRoom room) async {
    return await _roomService.createRoom(room);
  }

  Future<PomodoroRoom?> joinRoom(String roomcode) async {
    return await _roomService.joinRoom(roomcode);
  }

  Future<void> leaveRoom(String roomCode) async {
    return await _roomService.leaveRoom(roomCode);
  }

  Future<PomodoroRoom?> recentlyFetch() async {
    final roomdata = await _roomService.recentlyFetch();
    if (roomdata != null) {
      return PomodoroRoom.fromRealtimeMap(roomdata);
    } else {
      return null;
    }
  }

  Future<String?> joinedRoomFetch() async {
    return await _roomService.joinedRoomFetch();
  }

  // Future<List<PomodoroRoom>> fetchAllRooms(){
  //   return _roomService.fetchAllRooms();
  // }
}
