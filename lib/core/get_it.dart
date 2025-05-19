import 'package:get_it/get_it.dart';
import 'package:prj/ViewModel/Cubits/RoomOperations/Room_Cubit.dart';
import 'package:prj/ViewModel/Repositories/room_repository.dart';

import '../ViewModel/Services/room_service.dart';

final getIt = GetIt.instance;
void setUpLocator() {
  //Room
  getIt.registerLazySingleton<RoomService>(() => RoomService());
  getIt.registerLazySingleton<RoomRepository>(
    () => RoomRepository(getIt<RoomService>()),
  );

  getIt.registerFactory<RoomCubit>(() => RoomCubit(getIt<RoomRepository>()));
}


