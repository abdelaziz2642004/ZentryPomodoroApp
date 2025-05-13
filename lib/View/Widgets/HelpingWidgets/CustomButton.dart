import 'package:flutter/cupertino.dart';
import 'package:prj/View/Widgets/HelpingWidgets/CustomContainer.dart';

class CustomButton extends StatelessWidget {
  VoidCallback onTap;
  Widget content;
  Color bgColor;
  double? width;
  double? height;

  CustomButton({super.key, required this.onTap, required this.content, required this.bgColor, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      color: bgColor,
      vPadding: 8,
      width: width,
      child: GestureDetector(onTap: onTap, child: content),
    );
  }
}
