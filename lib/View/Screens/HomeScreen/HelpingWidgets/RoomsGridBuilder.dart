import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Roomsgridbuilder extends StatelessWidget {
  const Roomsgridbuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder:
          (context, index) => Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                "Room ${index + 1}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
    );
  }
}
