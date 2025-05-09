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
      TextEditingController();
  final List<TextEditingController> tagsController = [];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/CreateRoomBg2.jpg',
              // make sure this exists in your assets
              fit: BoxFit.cover,
              //height: 600,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: IntrinsicHeight(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 600),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Create Room",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: darkMainColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: CreateRoomForm(
                          formKey: _formKey,
                          nameController: nameController,
                          numberOfSessionsController: numberOfSessionsController,
                          tagsController: tagsController,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const RoomControl(),
                        CreateButton(formKey: _formKey),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
