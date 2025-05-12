import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class PomodoroRoom {
  final String _roomCode;
  final String _creatorId;
  /////////////////////////////
  final Timestamp _createdAt;
  int _workDuration;
  int _breakDuration;
  int _totalSessions;
  /////////////////////////////

  bool _availableRoom;
  String _name;
  int _capacity;
  // bool _workPhase;
  // int _passedSessions;

  bool isPublic;
  List<String> tags;
  List<String> joinedUsers = [];

  PomodoroRoom({
    String? roomCode,
    required String creatorId,
    required Timestamp createdAt,
    required bool availableRoom,
    required String name,
    required int capacity,
    // required bool workPhase,
    // required Timestamp phaseStartTime,
    required int workDuration,
    required int breakDuration,
    required bool isPublic,
    required int totalSessions,
    // required int passedSessions,
    required List<String> tags,
    required List<String> joinedUsers,
  }) : _roomCode = roomCode ?? const Uuid().v4(),
        _creatorId = creatorId,
        _createdAt = createdAt,
        _availableRoom = availableRoom,
        _name = name,
        _capacity = capacity,
  //  _workPhase = workPhase,
        _workDuration = workDuration,
        _breakDuration = breakDuration,
        this.isPublic = isPublic,
        _totalSessions = totalSessions,
  // //  _passedSessions = passedSessions,
        this.tags = tags,
        this.joinedUsers = joinedUsers;

  factory PomodoroRoom.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PomodoroRoom(
      roomCode: doc.id,
      creatorId: data['creatorId'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      availableRoom: data['availableRoom'] ?? true,
      name: data['name'] ?? '',
      capacity: data['capacity'] ?? 0,
      // workPhase: data['workPhase'] ?? true,
      // // phaseStartTime: data['phaseStartTime'] ?? Timestamp.now(),
      workDuration: data['workDuration'] ?? 25,
      breakDuration: data['breakDuration'] ?? 5,
      isPublic: data['Public'] ?? true,
      totalSessions: data['numberOfSessions'] ?? 0,
      // passedSessions: data['passedSessions'] ?? 0,
      tags: List<String>.from(data['tags'] ?? []),
      joinedUsers: List<String>.from(data['joinedUsers'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'roomCode': _roomCode,
      'creatorId': _creatorId,
      'createdAt': _createdAt,
      'availableRoom': _availableRoom,
      'name': _name,
      'capacity': _capacity,
      // 'workPhase': _workPhase,
      'workDuration': _workDuration,
      'breakDuration': _breakDuration,
      'Public': isPublic,
      'numberOfSessions': _totalSessions,
      // 'passedSessions': _passedSessions,
      'tags': tags,
      'joinedUsers': joinedUsers,
    };
  }

  // Getters
  String get roomCode => _roomCode;
  String get creatorId => _creatorId;
  Timestamp get createdAt => _createdAt;

  bool get availableRoom => _availableRoom;
  String get name => _name;
  int get capacity => _capacity;
  // bool get workPhase => _workPhase;
  int get workDuration => _workDuration;
  int get breakDuration => _breakDuration;
  int get totalSessions => _totalSessions;
  // // int get passedSessions => _passedSessions;

  // Setters
  set availableRoom(bool value) => _availableRoom = value;
  set name(String value) => _name = value;
  set capacity(int value) => _capacity = value;
  // set workPhase(bool value) => _workPhase = value;
  set workDuration(int value) => _workDuration = value;
  set breakDuration(int value) => _breakDuration = value;
  set totalSessions(int value) => _totalSessions = value;
// // set passedSessions(int value) => _passedSessions = value;
}



///
///
/// the break sessions= totalSessions - 1
// so end date should be the createdAt + (totalSessions * workDuration) + (totalSessions - 1) * breakDuration

// for example if we have 2 sessions of 10 mins , and it started at 7:00 :D
// the end date should be 7:00 + (2*10) + (1*5) = 7:25 exactly  :D

// given that someone entered at 7:10 , we need to know the following
//what phase now we are in
// when exactly are we in the phase
// and how many sessions we passed

// 7:30 - 7:10 = 20 mins
// 20 mins=  1 work session ( 10 mins ) + 1 break session ( 5 mins )
//and we are in the second work phase now and remaining time is 10 min

// we need an equation to get these info
// elapsedTime = currentTime - createdAt
// fullcycle= workduration + breakDuration
// NumberOfCyclesPassed = elapsedTime / fullcycle

//elapsedTime = 20 mins
// fullcycle = 10 + 5 = 15
// NumberOfCyclesPassed = 20 / 15 = 1.33 = 1
// so we passed 1 cylce ( 1 work phase and 1 break phase )
// now we need to know the remaining time
// remainingTime = elapsedTime - (NumberOfCyclesPassed * fullcycle)
// remainingTime = 20 - (1 * 15) = 5
// or , remainingTime = elapsedTime % fullcycle :D :D :D
// remainingTime = 20 % 15 = 5

// now we need to know the current phase
// if remainingTime < workDuration then we are in the work phase
// and we will handle and make sure that workduration is always more than breakDuration
// else we are in the break phase
// so we are in the work phase now
// and the remaining time is 5 mins

// another example , we are at 7:23,
// but instead we have 3 sessions , meaning we should end at 7:40 ( 7:00 + (3*10) + (2*5) = 7:40)
// so the elapsed time is 7:23 - 7:00 = 23 mins
// fullcycle = 10 + 5 = 15
// NumberOfCyclesPassed = 23 / 15 = 1.53 = 1
// remainingTime for the current phase ( work phase ) = 23 - (1 * 15) = 8
// or remainingTime = 23 % 15 = 8
// so we are in the work phase now for 8 mins
// and the remaining time is 2 mins for this phase