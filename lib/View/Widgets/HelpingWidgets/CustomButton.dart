import 'package:flutter/cupertino.dart';
import 'package:prj/View/Widgets/HelpingWidgets/CustomContainer.dart';

class CustomButton extends StatelessWidget {
  VoidCallback onTap;
  Widget content;
  Color bgColor;
  double? width;
  double? height;
  double? hPadding;
  double? vPadding;

  CustomButton({
    super.key,
    required this.onTap,
    required this.content,
    required this.bgColor,
    this.width,
    this.height,
    this.hPadding,
    this.vPadding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomContainer(
        color: bgColor,
        width: width,
        vPadding: vPadding ?? 2,
        hPadding: hPadding ?? 4,
        child: content,
      ),
    );
  }
}
