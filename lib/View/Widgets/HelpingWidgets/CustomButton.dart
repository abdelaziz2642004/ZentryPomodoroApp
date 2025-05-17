import 'package:flutter/cupertino.dart';
import 'package:prj/View/Widgets/HelpingWidgets/CustomContainer.dart';

class CustomButton extends StatelessWidget {
  VoidCallback onTap;
  Widget content;
  Color bgColor;
  double? width;
  double? height;

  CustomButton({
    super.key,
    required this.onTap,
    required this.content,
    required this.bgColor,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomContainer(
        color: bgColor,
        width: width,
        vPadding: 8, child: content
      ),
    );
  }
}
