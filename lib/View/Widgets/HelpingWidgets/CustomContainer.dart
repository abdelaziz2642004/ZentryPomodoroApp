import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/colors.dart';

class CustomContainer extends StatelessWidget {
  Widget child;
  CustomContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: light,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: dark, offset: Offset(2, 2), blurRadius: 6),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Center(child: child),
    );
  }
}
