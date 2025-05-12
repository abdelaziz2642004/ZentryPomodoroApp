import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prj/View/Widgets/HelpingWidgets/FormTextTitle.dart';
import 'package:prj/View/Widgets/HelpingWidgets/CustomContainer.dart';
import 'package:prj/core/colors.dart';

class ScheduleStartEndPicker extends StatefulWidget {
  final bool isScheduled;
  final ValueChanged<bool> onScheduledChanged;

  const ScheduleStartEndPicker({
    super.key,
    required this.isScheduled,
    required this.onScheduledChanged,
  });

  @override
  State<ScheduleStartEndPicker> createState() => _ScheduleStartEndPickerState();
}

class _ScheduleStartEndPickerState extends State<ScheduleStartEndPicker> {
  DateTime? startDateTime;
  DateTime? endDateTime;

  Future<void> _pickDateTime({required bool isStart}) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final selected = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          if (isStart) {
            startDateTime = selected;
          } else {
            endDateTime = selected;
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          title: const FormTextTitle(text: "Schedule"),
          value: widget.isScheduled,
          onChanged: widget.onScheduledChanged,
          activeColor: darkSecondaryColor,
          activeTrackColor: lightSecondaryColor,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FormTextTitle(
                text: "Starts On:",
                color: widget.isScheduled ? darkMainColor : grey,
                shadow: widget.isScheduled ? lightSecondaryColor : darkGrey,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: CustomContainer(
                  hPadding: 12,
                  vPadding: 10,
                  color: widget.isScheduled ? light : lightGrey,
                  child: GestureDetector(
                    onTap: () {
                      if (widget.isScheduled) {
                        _pickDateTime(isStart: true);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FormTextTitle(
                          text:
                              startDateTime == null
                                  ? "Select date"
                                  : DateFormat(
                                    'dd/MM/yyyy @hh:mm a',
                                  ).format(startDateTime!),

                          color: widget.isScheduled ? darkMainColor : grey,
                          fontWeight: FontWeight.w500,
                          shadow: widget.isScheduled ? light : darkGrey,
                        ),
                        Icon(
                          Icons.calendar_today_rounded,
                          color: widget.isScheduled ? darkMainColor : darkGrey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
