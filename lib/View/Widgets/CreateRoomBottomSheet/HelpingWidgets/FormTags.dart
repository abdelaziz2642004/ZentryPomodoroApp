import 'package:flutter/material.dart';
import 'package:prj/View/Widgets/HelpingWidgets/CustomContainer.dart';

import '../../../../core/colors.dart';
import '../CreateRoom.dart';
import 'FormTagItem.dart';
import '../../HelpingWidgets/FormTextTitle.dart';

class FormTags extends StatefulWidget {
  FormTags({super.key, required this.tagsController});

  List<TextEditingController> tagsController;

  @override
  State<FormTags> createState() => _FormTagsState();
}

class _FormTagsState extends State<FormTags> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          const FormTextTitle(text: "Tags"),
          Container(
            height: 60,
            child: ListView.builder(
              itemCount: widget.tagsController.length + 1,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (index == widget.tagsController.length) {
                  if (widget.tagsController.length >= 5) return null;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 5),
                    child: CustomContainer(
                      hPadding: 12,
                      color: lightSecondaryColor,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.tagsController.add(TextEditingController());
                          });
                        },
                        child: const Icon(Icons.add, size: 20,),
                      ),
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
      ),
    );
  }
}
