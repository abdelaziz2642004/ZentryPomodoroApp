import 'package:flutter/material.dart';
import 'package:prj/View/Widgets/HelpingWidgets/FormTextTitle.dart';
import 'Capacity.dart';
import 'CreateButton.dart';
import 'FormTags.dart';
import 'NumberOfSessions.dart';
import 'RoomControl.dart';
import 'RoomName.dart';
import 'Scheduler.dart';

import 'WorkBreakDurationPicker.dart';

class CreateRoomForm extends StatefulWidget {
  CreateRoomForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.nameController,
    required this.numberOfSessionsController,
    required this.tagsController,
    required this.capacityController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController nameController;
  final TextEditingController numberOfSessionsController;
  final List<TextEditingController> tagsController;
  final TextEditingController capacityController;

  @override
  State<CreateRoomForm> createState() => _CreateRoomFormState();
}

class _CreateRoomFormState extends State<CreateRoomForm> {
  Duration workDuration = const Duration(minutes: 50);
  bool isScheduled = false;
  void _incrementCapacity() {
    int current = int.tryParse(widget.capacityController.text) ?? 0;
    if (current < 50) {
      setState(() {
        widget.capacityController.text = (current + 1).toString();
      });
    }
  }

  void _decrementCapacity() {
    int current = int.tryParse(widget.capacityController.text) ?? 0;
    if (current > 1) {
      setState(() {
        widget.capacityController.text = (current - 1).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      child: Column(
        children: [
          RoomName(widget: widget),
          const SizedBox(height: 16),
          NumberOfSessions(
            numberOfSessionsController: widget.numberOfSessionsController,
          ),
          const SizedBox(height: 15),
          WorkBreakDurationPicker(
            duration: const Duration(minutes: 50),
            dialogTitle: "Set Work Duration",
            text: "Set Work Duration",
          ),
          const SizedBox(height: 15),
          WorkBreakDurationPicker(
            duration: const Duration(minutes: 10),
            dialogTitle: "Set Break Duration",
            text: "Set Break Duration",
          ),
          const SizedBox(height: 15),
          const FormTextTitle(text: "Room Capacity"),
          Capacity(
            capacityController: widget.capacityController,
            incrementCapacity: _incrementCapacity,
            decrementCapacity: _decrementCapacity,
          ),
          FormTags(tagsController: widget.tagsController),
          ScheduleStartEndPicker(
            isScheduled: isScheduled,
            onScheduledChanged: (val) {
              setState(() => isScheduled = val);
            },
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const RoomControl(),
              CreateButton(formKey: widget._formKey),
            ],
          ),
        ],
      ),
    );
  }
}
