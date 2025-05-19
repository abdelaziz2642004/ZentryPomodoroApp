import 'package:flutter/cupertino.dart';

import '../../../../../../core/colors.dart';

class SessionInfo extends StatelessWidget {
  int numberOfSessions;
  SessionInfo({
    super.key,
    required this.numberOfSessions
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: lightGrey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        "1/$numberOfSessions sessions",
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}
