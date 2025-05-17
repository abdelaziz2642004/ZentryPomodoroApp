import 'package:flutter/material.dart';

import 'RoomGridItems/RoomGridItem.dart';


class Roomsgridbuilder extends StatelessWidget {
  const Roomsgridbuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.64,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) => RoomGridItem(),
    );
  }
}


