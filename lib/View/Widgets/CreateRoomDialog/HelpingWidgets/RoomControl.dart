import 'package:flutter/material.dart';
import 'package:prj/core/colors.dart';

class RoomControl extends StatefulWidget {
  const RoomControl({super.key});

  @override
  _RoomControlState createState() => _RoomControlState();
}

class _RoomControlState extends State<RoomControl> {
  bool isPrivate = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isPrivate = !isPrivate;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: isPrivate ? darkSecondaryColor : darkGrey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              isPrivate ? Icons.lock : Icons.lock_open,
              color: white,
            ),
            const SizedBox(width: 8),
            Text(
              isPrivate ? "Private" : "Public",
              style: const TextStyle(color: white),
            ),
          ],
        ),
      ),
    );
  }
}
