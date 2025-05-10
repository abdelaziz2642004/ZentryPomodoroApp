import 'package:flutter/cupertino.dart';

import '../../../core/colors.dart';

class FormTextTitle extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final Color color;
  final Color shadow;

  const FormTextTitle({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.w600,
    this.color = white,
    this.shadow = darkMainColor,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: fontWeight,
          fontSize: 16,
          color: color,
          shadows: [
            Shadow(color: shadow, blurRadius: 3, offset: const Offset(1, 2)),
          ],
        ),
      ),
    );
  }
}
