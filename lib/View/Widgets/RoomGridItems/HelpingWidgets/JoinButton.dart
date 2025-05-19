
import 'package:flutter/material.dart';

import '../../../../../../core/colors.dart';
import '../../HelpingWidgets/CustomButton.dart';

class JoinButton extends StatelessWidget {
  const JoinButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      //width: 15,
      hPadding: 8,
      onTap: () {},
      content: const Icon(Icons.play_arrow, color: white,size: 22,),
      // content: const Text(
      //   "Join",
      //   style: TextStyle(color: white),
      // ),
      bgColor: mainColor,
    );
  }
}