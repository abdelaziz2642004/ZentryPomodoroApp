import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/colors.dart';

class CustomContainer extends StatelessWidget {
  Widget child;
  final Color color;
  final double hPadding;
  final double vPadding;
  double? width;
  double? height;

  CustomContainer({
    super.key,
    required this.child,
    this.hPadding = 6,
    this.vPadding = 2,
    this.color = light,
    this.width,
    this.height
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: dark, offset: Offset(2, 2), blurRadius: 6),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
      child: Center(child: child),
    );
  }
}
