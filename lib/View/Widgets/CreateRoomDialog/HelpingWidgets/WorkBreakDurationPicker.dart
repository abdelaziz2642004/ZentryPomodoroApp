import 'package:duration_time_picker/duration_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/colors.dart';
import '../../HelpingWidgets/CustomContainer.dart';
import '../../HelpingWidgets/FormTextTitle.dart';

class WorkBreakDurationPicker extends StatefulWidget {
  Duration duration;
  String text;
  String dialogTitle;

  WorkBreakDurationPicker({
    super.key,
    required this.duration,
    required this.dialogTitle,
    required this.text,
  });

  @override
  State<WorkBreakDurationPicker> createState() =>
      _WorkBreakDurationPickerState();
}

class _WorkBreakDurationPickerState extends State<WorkBreakDurationPicker> {
  late Duration workDuration;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FormTextTitle(text: widget.text),
        CustomContainer(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: Text(widget.dialogTitle),
                        content: DurationTimePicker(
                          duration: workDuration,
                          onChange: (Duration value) {
                            setState(() {
                              workDuration = value;
                            });
                          },
                        ),
                      ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.timelapse_outlined),
                  Text(
                    "${widget.duration.inMinutes} min",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
