import 'package:flutter/material.dart';
import 'package:prj/View/Screens/HomeScreen/HelpingWidgets/profileAvatar.dart';
import 'package:prj/core/colors.dart';

class Customappbar {
  static AppBar build() {
    return AppBar(
      title: const Text(
        'ZenTry',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: mainColor,
      actions: [const ProfileAvatar(), Container(width: 20)],
    );
  }
}
