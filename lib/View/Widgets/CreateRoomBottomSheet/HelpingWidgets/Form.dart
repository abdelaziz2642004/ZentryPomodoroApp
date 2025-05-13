import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/Models/PomodoroRoom.dart';
import 'package:prj/View/Widgets/HelpingWidgets/FormTextTitle.dart';
import '../../../../ViewModel/Cubits/Room/create_room_cubit.dart';
import '../../../../core/SnackBars/FailedSnackBar.dart';
import '../../../../core/SnackBars/SuccessSnackBar.dart';
import 'Capacity.dart';
import 'CreateButton.dart';
import 'FormTags.dart';
import 'NumberOfSessions.dart';
import 'RoomControl.dart';
import 'RoomName.dart';
import 'Scheduler.dart';
import 'WorkBreakDurationPicker.dart';
import 'package:firebase_auth/firebase_auth.dart';


class CreateRoomForm extends StatefulWidget {
  CreateRoomForm({super.key});

  @override
  State<CreateRoomForm> createState() => _CreateRoomFormState();
}

class _CreateRoomFormState extends State<CreateRoomForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberOfSessionsController =
      TextEditingController(text: "4");
  final List<TextEditingController> tagsController = [];
  final TextEditingController capacityController = TextEditingController(
    text: '25',
  );
  bool isPrivate = false;

  int workDuration = 50;
  int breakDuration = 10;

  bool isScheduled = false;
  Timestamp scheduleTime = Timestamp.now();

  void _incrementCapacity() {
    int current = int.tryParse(capacityController.text) ?? 0;
    if (current < 50) {
      setState(() {
        capacityController.text = (current + 1).toString();
      });
    }
  }

  void _decrementCapacity() {
    int current = int.tryParse(capacityController.text) ?? 0;
    if (current > 1) {
      setState(() {
        capacityController.text = (current - 1).toString();
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    numberOfSessionsController.dispose();
    capacityController.dispose();
    for (var controller in tagsController) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateRoomCubit, CreateRoomState>(
      listener: (context, state) {
        if (state is CreateRoomFailure) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(FailedSnackBar());
        } else if (state is CreateRoomSuccess) {
          ScaffoldMessenger.of(context).clearSnackBars();
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(SuccessSnackBar());
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            RoomName(nameController: nameController),
            const SizedBox(height: 16),
            NumberOfSessions(
              numberOfSessionsController: numberOfSessionsController,
            ),
            const SizedBox(height: 15),
            WorkBreakDurationPicker(
              duration: workDuration,
              limit: 180,
              dialogTitle: "Set Work Duration",
              text: "Set Work Duration",
              onDurationSelected: (int value) {
                setState(() {
                  workDuration = value;
                });
              },
            ),
            const SizedBox(height: 15),
            WorkBreakDurationPicker(
              duration: breakDuration,
              limit: 60,
              dialogTitle: "Set Break Duration",
              text: "Set Break Duration",
              onDurationSelected: (int value) {
                setState(() {
                  breakDuration = value;
                });
              },
            ),
            const SizedBox(height: 15),
            const FormTextTitle(text: "Room Capacity"),
            Capacity(
              capacityController: capacityController,
              incrementCapacity: _incrementCapacity,
              decrementCapacity: _decrementCapacity,
            ),
            FormTags(tagsController: tagsController),
            ScheduleStartEndPicker(
              isScheduled: isScheduled,
              onScheduledChanged: (value) {
                setState(() => isScheduled = value);
              },
              onScheduleTimeSelected:(value){
                  scheduleTime = value;
              }
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoomControl(
                  isPrivate: isPrivate,
                  onToggle: () {
                    setState(() {
                      isPrivate = !isPrivate;
                    });
                  },
                ),
                CreateButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final room = PomodoroRoom(
                        creatorId: FirebaseAuth.instance.currentUser!.uid,
                        createdAt: Timestamp.now(),
                        availableRoom: true,
                        name: nameController.text,
                        capacity: int.parse(capacityController.text),
                        workDuration: workDuration,
                        breakDuration: breakDuration,
                        isPublic: !isPrivate,
                        totalSessions: int.parse(
                          numberOfSessionsController.text,
                        ),
                        tags: tagsController.map((e) => e.text).toList(),
                        joinedUsers: [], isScheduled: isScheduled, scheduleTime: scheduleTime,
                      );
                      context.read<CreateRoomCubit>().createRoom(room: room);
                    } else {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(FailedSnackBar());
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
