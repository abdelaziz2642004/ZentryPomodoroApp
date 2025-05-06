import 'package:cloud_firestore/cloud_firestore.dart';

class PomodoroRoom {
  final String id;
  final String name;
  final int capacity;
  bool workPhase; // mutable
  Timestamp phaseStartTime; // mutable
  final int workDuration;
  final int breakDuration;
  final String creatorId;
  final Timestamp createdAt;
  final bool availableRoom;
  final bool isPublic;
  final String roomCode;
  final int totalSessions;
  int passedSessions; // mutable
  final List<String> tags;
  List<String> joinedUsers; // mutable

  PomodoroRoom({
    required this.id,
    required this.name,
    required this.capacity,
    required this.workPhase,
    required this.phaseStartTime,
    required this.workDuration,
    required this.breakDuration,
    required this.creatorId,
    required this.createdAt,
    required this.availableRoom,
    required this.isPublic,
    required this.roomCode,
    required this.totalSessions,
    required this.passedSessions,
    required this.tags,
    required this.joinedUsers,
  });

  factory PomodoroRoom.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PomodoroRoom(
      id: doc.id,
      name: data['name'] ?? '',
      capacity: data['capacity'] ?? 0,
      workPhase: data['workPhase'] ?? true,
      phaseStartTime: data['phaseStartTime'] ?? Timestamp.now(),
      workDuration: data['workDuration'] ?? 25,
      breakDuration: data['breakDuration'] ?? 5,
      creatorId: data['creatorId'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      availableRoom: data['availableRoom'] ?? true,
      isPublic: data['Public'] ?? true,
      roomCode: data['roomCode'] ?? '',
      totalSessions: data['numberOfSessions'] ?? 0,
      passedSessions: data['passedSessions'] ?? 0,
      tags: List<String>.from(data['tags'] ?? []),
      joinedUsers: List<String>.from(data['joinedUsers'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'capacity': capacity,
      'workPhase': workPhase,
      'phaseStartTime': phaseStartTime,
      'workDuration': workDuration,
      'breakDuration': breakDuration,
      'creatorId': creatorId,
      'createdAt': createdAt,
      'availableRoom': availableRoom,
      'Public': isPublic,
      'roomCode': roomCode,
      'numberOfSessions': totalSessions,
      'passedSessions': passedSessions,
      'tags': tags,
      'joinedUsers': joinedUsers,
    };
  }
}
