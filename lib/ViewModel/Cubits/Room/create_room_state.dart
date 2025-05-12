part of 'create_room_cubit.dart';

abstract class CreateRoomState {}

class CreateRoomInitial extends CreateRoomState {}

class CreateRoomLoading extends CreateRoomState {}

class CreateRoomSuccess extends CreateRoomState {}

class CreateRoomFailure extends CreateRoomState {
  final String error;

  CreateRoomFailure(this.error);
}
