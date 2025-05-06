import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/View/Screens/changePassword.dart/changePasswordScreen.dart';
import 'package:prj/ViewModel/Cubits/accountOperations/account_cubit.dart';
import 'package:prj/ViewModel/Cubits/accountOperations/account_states.dart';
import 'package:prj/core/colors.dart';
import 'package:prj/main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountCubit, AccountStates>(
      listener: (context, state) {
        if (state is UserDeletionSuccess) {
          Navigator.of(context).pushAndRemoveUntil(
            // wow :D nice to know
            MaterialPageRoute(builder: (context) => const MyApp()),
            (route) => false,
          );
        } else if (state is UserDeletionError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Settings'),
            backgroundColor: Colors.white,
          ),
          body: BlocBuilder<AccountCubit, AccountStates>(
            builder: (context, state) {
              if (state is accountLoadingState) {
                // Show a loading indicator while the account is being deleted
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                children: [
                  if (FirebaseAuth.instance.currentUser != null) ...[
                    ListTile(
                      title: const Text('Change Password'),
                      trailing: const Icon(Icons.lock, color: mainColor),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChangePasswordScreen(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text('Delete Account'),
                      trailing: const Icon(Icons.delete, color: Colors.red),
                      onTap: () async {
                        await BlocProvider.of<AccountCubit>(
                          context,
                        ).deleteAccount(context);
                      },
                    ),
                    const Divider(),
                  ],
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Filters ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
