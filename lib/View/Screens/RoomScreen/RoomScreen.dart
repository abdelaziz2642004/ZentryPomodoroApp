import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/View/Screens/RoomScreen/HelpingWidgets/JoinedUsersPart.dart';
import 'package:prj/View/Screens/RoomScreen/HelpingWidgets/RoomAppBar.dart';
import 'package:prj/View/Screens/RoomScreen/HelpingWidgets/RoomDetails&Timer.dart';
import 'package:prj/ViewModel/Cubits/Auth/Auth_cubit.dart';
import 'package:prj/ViewModel/Cubits/RoomOperations/Room_Cubit.dart';

class RoomScreen extends StatefulWidget {
  final String roomCode;

  const RoomScreen({Key? key, required this.roomCode}) : super(key: key);

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  @override
  void initState() {
    super.initState();
    final currentUser = BlocProvider.of<AuthCubit>(context).user;
    BlocProvider.of<RoomCubit>(context).joinRoom(widget.roomCode, currentUser!);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await leaveroom(context, widget.roomCode);
      },
      child: Scaffold(
        appBar: RoomAppBar.build(widget.roomCode, context),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Room Details",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const RoomDetailsAndTimer(),

                const SizedBox(height: 16),
                const Text(
                  "Users in Room",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Joineduserspart(roomCode: widget.roomCode),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
