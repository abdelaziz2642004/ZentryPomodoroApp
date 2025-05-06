// done
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/View/Screens/SettingsScreen./SettingsScreen.dart';
import 'package:prj/ViewModel/Cubits/Auth/Auth_cubit.dart';
import 'package:prj/ViewModel/Cubits/Auth/Auth_states.dart';
import 'package:prj/core/colors.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AuthErrorState) {
          return const Center(child: Icon(Icons.error, color: Colors.red));
        } else if (state is AuthSuccessState || state is AuthInitialState) {
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
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink(); // Default fallback
        }
      },
    );
  }
}
