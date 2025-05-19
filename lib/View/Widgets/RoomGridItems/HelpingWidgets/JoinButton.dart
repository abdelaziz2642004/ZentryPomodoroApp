
import 'package:flutter/cupertino.dart';

import '../../../../../../core/colors.dart';
import '../../HelpingWidgets/CustomButton.dart';

class JoinButton extends StatelessWidget {
  const JoinButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomButton(
        onTap: () {},
        content: const Text(
          "Join",
          style: TextStyle(color: white),
        ),
        bgColor: mainColor,
      ),
    );
  }
}