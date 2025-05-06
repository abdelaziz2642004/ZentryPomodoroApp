import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/ViewModel/Cubits/GuestMode/GuestMode_States.dart';

class GuestmodeCubit extends Cubit<GuestmodeStates> {
  GuestmodeCubit() : super(GuestModeDisabledState());

  void enableGuestMode() {
    emit(GuestModeEnabledState());
  }

  void disableGuestMode() {
    emit(GuestModeDisabledState());
  }
}
