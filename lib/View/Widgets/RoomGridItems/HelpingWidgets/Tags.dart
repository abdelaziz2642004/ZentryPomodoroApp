import 'package:flutter/cupertino.dart';

import '../../../../../../core/colors.dart';
import '../../HelpingWidgets/CustomContainer.dart';

class Tags extends StatelessWidget {
  const Tags({
    super.key,
    required this.tags,
  });

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tags.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 4),
            child: CustomContainer(
              color: secondaryColor,
              blurRadius: 1,
              vPadding: 0,
              hPadding: 8,
              child: Text(
                "#${tags[index]}",
                style: const TextStyle(
                  fontSize: 8,
                  color: white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
