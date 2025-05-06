import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/Models/User.dart';
import 'package:prj/ViewModel/Cubits/Auth/Auth_cubit.dart';
import 'package:prj/ViewModel/Cubits/Profile/profile_cubit.dart';
import 'package:prj/ViewModel/Cubits/Profile/profile_states.dart';
import 'package:prj/ViewModel/Cubits/accountOperations/account_states.dart';
import 'package:prj/core/functions.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  String fullName = '';

  @override
  void initState() {
    super.initState();
    FireUser currentUser =
        BlocProvider.of<AuthCubit>(context).user ?? FireUser();
    fullName = currentUser.fullName;
  }

  void _editFullName() {
    TextEditingController controller = TextEditingController(text: fullName);
    showDialog(
      context: context,
      builder:
          (context) => BlocConsumer<ProfileCubit, ProfileStates>(
            listener: (context, state) {
              if (state is FullNameSuccess) {
                Navigator.pop(context); // Close the dialog on success
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Full name updated successfully!'),
                  ),
                );
                setState(() {
                  fullName = BlocProvider.of<AuthCubit>(context).user!.fullName;
                });
              } else if (state is FullNameError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
            builder: (context, state) {
              if (state is accountLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }

              return AlertDialog(
                title: const Text('Edit Full Name'),
                content: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Enter new full name',
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      final newName = controller.text.trim();
                      if (newName.isNotEmpty) {
                        BlocProvider.of<AuthCubit>(context).user!.fullName =
                            newName;
                        await BlocProvider.of<ProfileCubit>(
                          context,
                        ).changeFullName(newName);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Name cannot be empty!'),
                          ),
                        );
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              );
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FullNameError) {
          return Center(
            child: Text(
              'Error loading full name ${state.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        FireUser currentUser =
            BlocProvider.of<AuthCubit>(context).user ?? FireUser();

        return Column(
          children: [
            if (currentUser.fullName != 'Guest')
              GestureDetector(
                onTap: _editFullName,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      capitalizeFirstLetterOfEachWord(fullName),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'DopisBold',
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.edit, size: 18, color: Colors.grey),
                  ],
                ),
              ),
            Text(currentUser.email, style: const TextStyle(color: Colors.grey)),
          ],
        );
      },
    );
  }
}
