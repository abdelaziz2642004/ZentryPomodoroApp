import 'package:flutter/material.dart';

import '../../HelpingWidgets/CustomContainer.dart';
import 'CustomTextFormField.dart';
import 'FormText.dart';

class NumberOfSessions extends StatelessWidget {
  const NumberOfSessions({
    super.key,
    required this.numberOfSessionsController,
  });

  final TextEditingController numberOfSessionsController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 3,
          child: FormTextTitle(text: "Number of Sessions"),
        ),
        Expanded(
          flex: 1,
          child: CustomContainer(
            child: CustomTextFormField(
              controller:
              numberOfSessionsController,
              validator: () {},
              keyboardType: TextInputType.number,
                textAlign: TextAlign.center
            ),
          ),
        ),
      ],
    );
  }
}
