import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreatorInfo extends StatelessWidget {
  const CreatorInfo({
    super.key,
    required this.creatorName,
  });

  final String creatorName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 10, backgroundColor: Colors.grey[300]),
        const SizedBox(width: 4),
        Text(
          "by $creatorName",
          style: const TextStyle(fontSize: 10, color: Colors.black54),
        ),
      ],
    );
  }
}