import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Models/User.dart';
import 'package:prj/ViewModel/Providers/userProvider.dart';
import 'package:prj/View/Screens/SettingsScreen./SettingsScreen.dart';
import 'package:prj/core/colors.dart';

class ProfileOptions extends ConsumerWidget {
  const ProfileOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    user currentUser = ref.read(userProvider).value ?? user();

    return Column(
      children: [
        ListTile(
          title: const Text(
            'Settings & Preferences',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'DopisBold',
            ),
          ),
          subtitle: const Text('Manage account settings'),
          leading: const Icon(Icons.settings, color: mainColor),
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              ),
        ),
      ],
    );
  }
}
