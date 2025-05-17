import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../HelpingWidgets/CustomContainer.dart';
import 'Form.dart';

class RoomName extends StatelessWidget {
  const RoomName({
    super.key,
    required this.nameController,
  });
  final TextEditingController nameController;
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: TextFormField(
        controller: nameController,
        validator:
            (value){
              if (value == null || value.isEmpty) {
                return "*Required";
              }

              if (value.length > 50) {
                return "should be <= 50 character";
              }
              return null;
            },

        decoration: const InputDecoration(
          labelText: "Room Name",
          border: InputBorder.none,
        ),
      ),
    );
  }
}