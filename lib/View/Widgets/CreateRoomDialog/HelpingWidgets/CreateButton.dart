import 'package:flutter/material.dart';

import '../../../../core/colors.dart';

class CreateButton extends StatelessWidget {
  const CreateButton({
    super.key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            // Handle create room action
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: mainColor,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          "Create",
          style: TextStyle(color: white),
        ),
      ),
    );
  }
}