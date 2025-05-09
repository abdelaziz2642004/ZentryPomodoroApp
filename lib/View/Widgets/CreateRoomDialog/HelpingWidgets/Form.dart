import 'package:flutter/material.dart';
import 'package:prj/View/Widgets/CreateRoomDialog/HelpingWidgets/FormText.dart';
import 'package:duration_time_picker/duration_time_picker.dart';
import 'package:prj/core/colors.dart';

import '../../HelpingWidgets/CustomContainer.dart';
import 'FormTags.dart';
import 'NumberOfSessions.dart';
import 'WorkBreakDurationPicker.dart';

class CreateRoomForm extends StatefulWidget {
  CreateRoomForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.nameController,
    required this.numberOfSessionsController,
    required this.tagsController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController nameController;
  final TextEditingController numberOfSessionsController;
  final List<TextEditingController> tagsController;

  @override
  State<CreateRoomForm> createState() => _CreateRoomFormState();
}

class _CreateRoomFormState extends State<CreateRoomForm> {
  Duration workDuration = const Duration(minutes: 50);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      child: Column(
        children: [
          CustomContainer(
            child: TextFormField(
              controller: widget.nameController,
              validator:
                  (value) =>
                      value == null || value.isEmpty
                          ? "Room name required"
                          : null,
              decoration: const InputDecoration(
                labelText: "Room Name",
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          NumberOfSessions(
            numberOfSessionsController: widget.numberOfSessionsController,
          ),
          FormTags(tagsController: widget.tagsController),
          const SizedBox(height: 10),
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
        ],
      ),
    );
  }
}
