import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Timetrackertoday extends StatelessWidget {
  const Timetrackertoday({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text("Today,", style: TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Text("5-5-2025", style: TextStyle(color: Colors.grey[600])),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            "3:00:00",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
