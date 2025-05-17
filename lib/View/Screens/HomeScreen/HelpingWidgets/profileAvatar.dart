// DONE
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prj/Models/User.dart';
import 'package:prj/View/Screens/ProfileScreen/profileScreen.dart';
import 'package:prj/ViewModel/Cubits/Profile/profile_cubit.dart';
import 'package:prj/ViewModel/Cubits/Profile/profile_states.dart';
import 'package:prj/ViewModel/Cubits/Auth/Auth_cubit.dart';
import 'package:prj/ViewModel/Cubits/Auth/Auth_states.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  void _openProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        return BlocBuilder<ProfileCubit, ProfileStates>(
          builder: (context, profileState) {
            if (authState is AuthLoadingState ||
                profileState is ProfileLoadingState) {
              // return const Center(child: CircularProgressIndicator());
            }

            if (authState is AuthErrorState ||
                profileState is ProfileErrorState) {
              return const Center(child: Icon(Icons.error, color: Colors.red));
            }

            if (authState is AuthSuccessState ||
                authState is AuthInitialState) {
              FireUser currentUser =
                  BlocProvider.of<AuthCubit>(context).user ?? FireUser();
              print(currentUser.email);

              return PopupMenuButton(
                itemBuilder:
                    (context) => const [
                      PopupMenuItem(
                        value: 1,
                        child: Text('Settings & Profile'),
                      ),
                    ],
                onSelected: (value) {
                  if (value == 1) _openProfile(context);
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      currentUser.ImageUrl.isNotEmpty
                          ? CachedNetworkImageProvider(currentUser.ImageUrl)
                          : const AssetImage('assets/images/profile.jpg')
                              as ImageProvider,
                ),
              );
            }

            return const SizedBox(); // default fallback
          },
        );
      },
    );
  }
}
