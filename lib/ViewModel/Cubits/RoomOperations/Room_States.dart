import 'package:prj/Models/PomodoroRoom.dart';
import 'package:prj/View/Screens/HomeScreen/HelpingWidgets/RecentlyJoined.dart';

class RoomStates {}

// Room General states

class RoomInitialState extends RoomStates {}

class RoomLoadingState extends RoomStates {}

// RoomCreation States

class RoomCreationSuccess extends RoomStates {}

class RoomCreationFailure extends RoomStates {
  final String error;
  RoomCreationFailure(this.error);
}

class RoomCreatingLoadingState extends RoomStates {}

// RoomJoin States

class RoomJoinSuccess extends RoomStates {
  PomodoroRoom room;
  RoomJoinSuccess(this.room);
}

class RoomJoinFailure extends RoomStates {
  final String error;
  RoomJoinFailure(this.error);
}

class RoomJoinLoadingState extends RoomStates {}

// RoomLeave States

class RoomLeaveSuccess extends RoomStates {}

class RoomLeaveFailure extends RoomStates {
  final String error;
  RoomLeaveFailure(this.error);
}

// RoomUpdate States
class RoomUpdateSuccess extends RoomStates {
  PomodoroRoom room;
  RoomUpdateSuccess(this.room);
}

class RoomUpdateFailure extends RoomStates {
  final String error;
  RoomUpdateFailure(this.error);
}

class RecentlyUpdated extends RoomStates {}
