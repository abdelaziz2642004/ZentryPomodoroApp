import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prj/Models/PomodoroRoom.dart';

class RoomService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createRoom(PomodoroRoom room) async {
    await _firestore.collection('rooms').add(room.toMap());
  }
}
