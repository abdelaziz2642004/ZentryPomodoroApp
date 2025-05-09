import 'package:flutter/cupertino.dart';

import '../../../../core/colors.dart';

class FormTextTitle extends StatelessWidget {
  final String text;

  const FormTextTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: white,
            shadows: [Shadow(color: darkMainColor, blurRadius: 3, offset: Offset(1,2))]
        ),
      ),
    );
  }
}

