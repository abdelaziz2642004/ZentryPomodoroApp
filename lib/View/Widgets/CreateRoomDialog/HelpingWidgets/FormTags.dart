import 'package:flutter/material.dart';

import '../../../../core/colors.dart';
import '../CreateRoom.dart';
import 'FormTagItem.dart';
import 'FormText.dart';

class FormTags extends StatefulWidget {
  FormTags({super.key, required this.tagsController});

  List<TextEditingController> tagsController;

  @override
  State<FormTags> createState() => _FormTagsState();
}

class _FormTagsState extends State<FormTags> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const FormTextTitle(text: "Tags"),
        Container(
          height: 60,
          child: ListView.builder(
            itemCount: widget.tagsController.length + 1,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              if (index == widget.tagsController.length) {
                return Container(
                  decoration: BoxDecoration(
                    color: grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        widget.tagsController.add(TextEditingController());
                      });
                    },
                    icon: Icon(Icons.add, size: 15),
                  ),
                );
              }
              return TagsFormItem(
                tagController: widget.tagsController[index],
                action: () {
                  setState(() {
                    widget.tagsController.removeAt(index);
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
