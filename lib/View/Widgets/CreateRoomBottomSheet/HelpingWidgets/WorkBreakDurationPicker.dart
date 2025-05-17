import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/colors.dart';
import '../../HelpingWidgets/CustomButton.dart';
import '../../HelpingWidgets/CustomContainer.dart';
import '../../HelpingWidgets/FormTextTitle.dart';

class WorkBreakDurationPicker extends StatefulWidget {
  int duration;
  int limit;
  String text;
  String dialogTitle;
  final Function(int) onDurationSelected;

  WorkBreakDurationPicker({
    super.key,
    required this.duration,
    required this.limit,
    required this.dialogTitle,
    required this.text,
    required this.onDurationSelected,
  });

  @override
  State<WorkBreakDurationPicker> createState() =>
      _WorkBreakDurationPickerState();
}

class _WorkBreakDurationPickerState extends State<WorkBreakDurationPicker> {
  List<int> durations = [];
  late int selectedDuration;

  @override
  void initState() {
    super.initState();
    durations = List<int>.generate(widget.limit, (i) => i + 1);
    selectedDuration = widget.duration;
  }

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
                  builder: (context) => AlertDialog(
                    backgroundColor: lightSecondaryColor,
                    title: FormTextTitle(
                      text: widget.dialogTitle,
                      color: mainColor,
                      fontSize: 25,
                      shadow: light,
                    ),
                    content: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: CupertinoPicker(
                              scrollController: FixedExtentScrollController(
                                initialItem: durations.indexOf(widget.duration),
                              ),
                              itemExtent: 35,
                              onSelectedItemChanged: (int index) {
                                setState(() {
                                  selectedDuration = durations[index];
                                });
                              },
                              children: durations
                                  .map((min) => Center(child: Text("$min")))
                                  .toList(),
                            ),
                          ),
                          CustomButton(
                            bgColor: mainColor,
                            width: MediaQuery.of(context).size.width * 0.5,
                            onTap: () {
                              widget.onDurationSelected(selectedDuration);
                              Navigator.pop(context);
                            },
                            content: const Text(
                              "Set",
                              style: TextStyle(
                                color: lightSecondaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.timelapse_outlined),
                  Text(
                    "${widget.duration} min",
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
