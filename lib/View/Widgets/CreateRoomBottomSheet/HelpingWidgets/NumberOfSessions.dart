import 'package:flutter/material.dart';

import '../../HelpingWidgets/CustomContainer.dart';
import '../../HelpingWidgets/CustomTextFormField.dart';
import '../../HelpingWidgets/FormTextTitle.dart';

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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "*Required";
                }

                final intValue = int.tryParse(value);
                if (intValue == null) {
                  return "not valid";
                }

                if (intValue <= 0) {
                  return "should be > 0";
                }

                if (intValue > 15) {
                  return "should be <= 15";
                }
                return null;
              },
              keyboardType: TextInputType.number,
                textAlign: TextAlign.center
            ),
          ),
        ),
      ],
    );
  }
}
