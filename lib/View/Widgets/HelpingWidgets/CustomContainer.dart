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
  double blurRadius;

  CustomContainer({
    super.key,
    required this.child,
    this.hPadding = 6,
    this.vPadding = 2,
    this.color = light,
    this.width,
    this.height,
    this.blurRadius = 3
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: dark, offset: const Offset(2, 2), blurRadius: blurRadius),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
      child: Center(child: child),
    );
  }
}
