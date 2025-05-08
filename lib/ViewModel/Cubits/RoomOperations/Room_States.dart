import 'package:prj/Models/PomodoroRoom.dart';

class RoomStates {}

class RoomInitialState extends RoomStates {}

class RoomLoadingState extends RoomStates {}

class RoomCreationSuccess extends RoomStates {}

class RoomCreationFailure extends RoomStates {
  final String error;
  RoomCreationFailure(this.error);
}

class RoomJoinSuccess extends RoomStates {
  PomodoroRoom room;
  RoomJoinSuccess(this.room);
}

class RoomJoinFailure extends RoomStates {
  final String error;
  RoomJoinFailure(this.error);
}

class RoomJoinLoadingState extends RoomStates {}

class RoomJoinInitialState extends RoomStates {}

class RoomLeaveSuccess extends RoomStates {}

class RoomLeaveFailure extends RoomStates {
  final String error;
  RoomLeaveFailure(this.error);
}
