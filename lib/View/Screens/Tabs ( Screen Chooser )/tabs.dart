import 'package:flutter/material.dart';

import 'package:prj/View/Screens/HomeScreen/HomeScreen.dart';
import 'package:prj/View/Screens/Tabs%20(%20Screen%20Chooser%20)/BottomNavBar.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsState();
}

class _TabsState extends State<TabsScreen> {
  int _index = 0;

  void rebuild(int index) {
    setState(() {
      _index = index;
    });
  }

  Widget _buildScreenChooser(int index, void Function(int) rebuild) {
    switch (index) {
      case 0:
        return const Homescreen();

      default:
        return const Homescreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.signOut();
    Widget buildScreen = _buildScreenChooser(_index, rebuild);
    return SafeArea(
      child: Scaffold(
        body: buildScreen,
        bottomNavigationBar: Bottomnavbar(index: _index, rebuild: rebuild),
      ),
    );
  }
}
