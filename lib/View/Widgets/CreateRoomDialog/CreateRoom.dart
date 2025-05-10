import 'package:flutter/material.dart';
import '../../../core/colors.dart';
import '../HelpingWidgets/CustomContainer.dart';
import 'HelpingWidgets/CreateButton.dart';
import 'HelpingWidgets/Form.dart';
import 'HelpingWidgets/FormTags.dart';
import 'HelpingWidgets/NumberOfSessions.dart';
import 'HelpingWidgets/RoomControl.dart';

class CreateRoom extends StatefulWidget {
  const CreateRoom({super.key});

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberOfSessionsController =
      TextEditingController(text: "4");
  final List<TextEditingController> tagsController = [];
  final TextEditingController capacityController = TextEditingController(
    text: '25',
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16)
              ),
              child: Image.asset("assets/images/CreateRoomBg2.jpg", fit: BoxFit.cover,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Create Room",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: darkMainColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CreateRoomForm(
                    formKey: _formKey,
                    nameController: nameController,
                    numberOfSessionsController: numberOfSessionsController,
                    tagsController: tagsController,
                    capacityController: capacityController,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
