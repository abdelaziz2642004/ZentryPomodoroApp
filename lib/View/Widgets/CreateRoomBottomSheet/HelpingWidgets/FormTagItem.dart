import 'package:flutter/material.dart';
import 'package:prj/View/Widgets/HelpingWidgets/CustomContainer.dart';
import 'package:prj/core/colors.dart';

class TagsFormItem extends StatefulWidget {
  final TextEditingController tagController;
  VoidCallback action;

  TagsFormItem({super.key, required this.tagController, required this.action});

  @override
  State<TagsFormItem> createState() => _TagsFormItemState();
}

class _TagsFormItemState extends State<TagsFormItem> {
  @override


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 8),
      child: IntrinsicWidth(
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 100),
          child: CustomContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: widget.tagController,
                    validator: (value) {},
                    decoration: const InputDecoration(
                      prefix: Text('#'),
                      border: InputBorder.none
                    ),
                    maxLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.white,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          widget.action();
                        },
                        child: Icon(Icons.remove, size: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
