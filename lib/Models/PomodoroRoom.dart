import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class PomodoroRoom {
  final String roomCode;
  final String creatorId;
  final Timestamp createdAt;

  bool availableRoom;
  String name;
  int capacity;
  bool workPhase;
  Timestamp phaseStartTime;
  int workDuration;
  int breakDuration;
  bool isPublic;
  int totalSessions;
  int passedSessions;
  List<String> tags;
  List<String> joinedUsers = [];

  PomodoroRoom({
    String? roomCode, // make it optional
    required this.creatorId,
    required this.createdAt,
    required this.availableRoom,
    required this.name,
    required this.capacity,
    required this.workPhase,
    required this.phaseStartTime,
    required this.workDuration,
    required this.breakDuration,
    required this.isPublic,
    required this.totalSessions,
    required this.passedSessions,
    required this.tags,
    required this.joinedUsers,
  }) : roomCode = roomCode ?? const Uuid().v4();

  factory PomodoroRoom.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PomodoroRoom(
      roomCode: data['roomCode'],
      creatorId: data['creatorId'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      availableRoom: data['availableRoom'] ?? true,
      name: data['name'] ?? '',
      capacity: data['capacity'] ?? 0,
      workPhase: data['workPhase'] ?? true,
      phaseStartTime: data['phaseStartTime'] ?? Timestamp.now(),
      workDuration: data['workDuration'] ?? 25,
      breakDuration: data['breakDuration'] ?? 5,
      isPublic: data['Public'] ?? true,
      totalSessions: data['numberOfSessions'] ?? 0,
      passedSessions: data['passedSessions'] ?? 0,
      tags: List<String>.from(data['tags'] ?? []),
      joinedUsers: List<String>.from(data['joinedUsers'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'roomCode': roomCode,
      'creatorId': creatorId,
      'createdAt': createdAt,
      'availableRoom': availableRoom,
      'name': name,
      'capacity': capacity,
      'workPhase': workPhase,
      'phaseStartTime': phaseStartTime,
      'workDuration': workDuration,
      'breakDuration': breakDuration,
      'Public': isPublic,
      'numberOfSessions': totalSessions,
      'passedSessions': passedSessions,
      'tags': tags,
      'joinedUsers': joinedUsers,
    };
  }
}
