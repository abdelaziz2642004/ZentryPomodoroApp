import 'package:flutter/cupertino.dart';
import 'package:prj/core/colors.dart';

import '../../HelpingWidgets/CustomContainer.dart';

class CapacityButton extends StatelessWidget {
  final IconData icon;
  VoidCallback onTap;

  CapacityButton({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CustomContainer(
        color: secondaryColor,
        hPadding: 3,
        child: GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icon, color: white),
          ),
        ),
      ),
    );
  }
}
