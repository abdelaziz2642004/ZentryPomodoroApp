// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:prj/Models/PomodoroRoom.dart';
//
// import 'package:prj/ViewModel/Cubits/Room/RoomDetails/room_details_state.dart';
//
// import '../../../Repositories/room_repository.dart';
//
// class RoomDetailsCubit extends Cubit<RoomDetailsState> {
//   final RoomRepository roomRepository;
//
//   RoomDetailsCubit(this.roomRepository) : super(RoomDetailsInitial());
//
//   Future<void> fetchAllRooms() async {
//     try{
//       emit(RoomDetailsLoading());
//
//       List<PomodoroRoom> allRooms = await roomRepository.fetchAllRooms();
//       emit(RoomDetailsSuccess(allRooms));
//
//     }
//     catch(e){
//       emit(RoomDetailsFailure(e.toString()));
//     }
//   }
// }
